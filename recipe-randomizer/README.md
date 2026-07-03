# 今日菜谱

一个可部署为静态网站的小应用，用来记录菜谱做法，并每天从“蔬菜、肉菜、汤”三类中随机选择。

## 多人共用菜谱库

当前版本支持 Supabase 云数据库。配置后，所有访问同一个网址的人都会读写同一份菜谱库。

未配置 Supabase 时，应用会自动进入“本地模式”，菜谱只保存在当前浏览器中，适合本地预览。

## 上传菜谱

页面支持上传 `.csv` 或 `.json` 菜谱文件。上传后会写入当前存储：

- 已配置 Supabase：上传到共享云端菜谱库。
- 未配置 Supabase：上传到当前浏览器本地菜谱库。

本项目已内置一份广东菜、客家菜预置文件：`preset-cantonese-hakka.csv`。如果要把这些预置菜谱导入共享云端库，在页面点击“上传菜谱”并选择这个文件即可。

CSV 表头可以使用中文或英文：

```csv
菜名,分类,用料,做法
蒜蓉生菜,蔬菜,"生菜、蒜、盐、蚝油","生菜洗净沥干。热锅爆香蒜末，下生菜大火快炒。"
```

也可以使用英文字段：

```csv
name,category,ingredients,steps
Garlic Lettuce,vegetable,"lettuce, garlic, salt","Stir fry quickly and season."
```

JSON 可以是数组：

```json
[
  {
    "name": "紫菜蛋花汤",
    "category": "soup",
    "ingredients": "紫菜、鸡蛋、葱、盐、香油",
    "steps": "水开后放入紫菜，淋入蛋液，加盐调味。"
  }
]
```

分类支持：`蔬菜/素菜/vegetable`、`肉菜/荤菜/meat`、`汤/汤菜/soup`。

## 图片步骤

手动记录菜谱时，可以在“图片步骤”里选择多张图片。图片会在浏览器中压缩后保存到菜谱数据里。

JSON 导入也支持 `image_steps` 字段，格式为图片 data URL 数组：

```json
[
  {
    "name": "示例菜",
    "category": "vegetable",
    "ingredients": "食材",
    "steps": "做法",
    "image_steps": ["data:image/jpeg;base64,..."]
  }
]
```

CSV 导入不适合携带图片，建议图片步骤通过页面手动添加。

## 今日菜谱长图

点击“下载长图”可以把当天抽到的蔬菜、肉菜、汤生成一张 PNG 长图，包含菜名、用料、做法和每道菜前两张步骤图，便于下载后分享。

## 配置 Supabase

1. 注册并登录 Supabase，新建一个项目。
2. 打开项目的 `SQL Editor`。
3. 复制 `supabase.sql` 的内容并执行，创建 `recipes` 表和公开读写策略。
4. 打开项目 `Settings -> API`。
5. 复制 `Project URL` 和 `anon public` key。
6. 修改 `config.js`：

```js
window.RECIPE_APP_CONFIG = {
  supabaseUrl: "你的 Project URL",
  supabaseAnonKey: "你的 anon public key"
};
```

注意：不要使用 `service_role` key。前端只能放 `anon public` key。

如果你之前已经执行过旧版 SQL，也可以重新执行当前 `supabase.sql`，它会自动补充 `image_steps` 字段。

## 部署方式

### Netlify

1. 登录 Netlify。
2. 选择 `Add new site -> Deploy manually`。
3. 将本目录拖进去。
4. 部署完成后会生成一个公开网址。

### GitHub Pages

1. 新建一个 GitHub 仓库。
2. 上传本目录中的所有文件。
3. 在仓库 `Settings -> Pages` 中选择 `Deploy from a branch`。
4. 分支选择 `main`，目录选择 `/root`。
5. 保存后等待 GitHub 生成访问地址。

### Vercel

1. 登录 Vercel。
2. 新建项目并导入包含本目录文件的仓库。
3. Framework 选择 `Other` 或保持默认。
4. 部署完成后会生成一个公开网址。

## 文件说明

- `index.html`：应用页面。
- `config.js`：Supabase 连接配置。
- `supabase.sql`：云端菜谱库建表和权限策略。
- `sample-recipes.csv`：菜谱上传示例文件。
- `preset-cantonese-hakka.csv`：广东菜、客家菜预置菜谱。
