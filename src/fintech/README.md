# 各国即时支付方式

即时支付（Instant Payment / Fast Payment）是指款项通常在数秒内到达收款账户、资金立即可用，并且原则上全年无休运行的账户到账户支付。它和银行卡支付、电子钱包并不是同一层概念：

- **即时支付系统**负责银行或支付机构之间的清算、结算与消息传递；
- **手机号、邮箱、二维码、虚拟支付地址**是方便用户识别收款人的“别名”或入口；
- 银行 App、电子钱包和商户收银台则是面向用户的产品界面。

因此，印度用户常说“用 UPI”，巴西用户说“用 Pix”，实际上既可能是转账，也可能是扫码消费；而 Apple Pay、Google Pay 等主要是钱包或卡片载体，并不等于一个国家的即时支付基础设施。

## 亚洲

| 国家或地区 | 主要系统或品牌 | 常见使用方式 | 特点 |
| --- | --- | --- | --- |
| 中国大陆 | 网上支付跨行清算系统（IBPS） | 银行 App 转账；支付宝、微信支付扫码或转账 | IBPS 支持跨行零售支付；支付宝和微信支付是覆盖面更广的商业钱包体系，两者不能简单画等号 |
| 中国香港 | FPS 转数快 | 手机号、邮箱、FPS ID、二维码 | 支持港元和人民币，银行与储值支付工具可以接入 |
| 印度 | UPI、IMPS | UPI ID、手机号、二维码、银行 App | UPI 是开放式即时支付接口，广泛用于个人转账、商户付款和自动扣款 |
| 日本 | Zengin System（全银系统） | 银行账号转账 | “More Time System”延长至夜间及节假日；用户端仍以银行转账为主，统一二维码支付的市场形态与 UPI、Pix 不同 |
| 韩国 | Electronic Banking System 等 | 银行 App、账号或手机号转账 | 较早实现近实时电子银行转账，移动银行普及度高 |
| 新加坡 | FAST；PayNow | 手机号、身份证/企业编号、虚拟支付地址、SGQR | FAST 是底层实时转账系统，PayNow 是易用的别名服务 |
| 马来西亚 | RPP；DuitNow | 手机号、身份证号、企业注册号、二维码 | DuitNow 覆盖转账和统一二维码支付 |
| 泰国 | PromptPay | 手机号、身份证号、二维码 | 低成本、覆盖个人和商户，是泰国二维码支付的核心 |
| 印度尼西亚 | BI-FAST；QRIS | 银行账号、手机号代理地址、二维码 | BI-FAST 负责快速转账，QRIS 统一不同钱包和银行的二维码受理 |
| 菲律宾 | InstaPay | 银行或电子钱包账号、二维码 | 面向小额实时转账，与批量清算系统 PESONet 分工 |
| 巴基斯坦 | Raast | Raast ID、手机号、银行账号 | 由央行推动，覆盖个人和商户即时支付 |

## 欧洲

| 国家或地区 | 主要系统或品牌 | 常见使用方式 | 特点 |
| --- | --- | --- | --- |
| 欧元区及 SEPA 参与地区 | SEPA Instant Credit Transfer（SCT Inst）；TIPS、RT1 等 | IBAN、银行 App，部分国家另有手机号别名 | 欧元通常在 10 秒内到账；欧盟法规要求即时转账收费不得高于同类普通转账，并逐步强制提供收付款与收款人核验 |
| 英国 | Faster Payments Service（FPS） | sort code + account number、手机银行；Paym 已停止 | 覆盖个人转账、账单和企业支付；银行通常会做收款人姓名核验 |
| 瑞典 | BiR / RIX-INST；Swish | 手机号、二维码 | Swish 是用户熟悉的入口，底层结算基础设施已向 RIX-INST 演进 |
| 挪威 | Straksbetalinger；Vipps | 手机号、二维码 | Vipps 将个人转账和商户付款整合在同一 App 中 |
| 丹麦 | Straksclearing；MobilePay | 手机号、二维码 | 实时清算与广泛使用的移动钱包结合 |
| 瑞士 | SIC IP；TWINT | 银行账号、手机号、二维码 | SIC IP 提供即时支付基础设施；TWINT 是本地主流移动支付产品 |
| 波兰 | Express Elixir；BLIK | 手机号、一次性代码、二维码 | BLIK 可用于转账、电商、线下和 ATM，但它与底层清算系统不是同一概念 |
| 土耳其 | FAST | 手机号、身份证号、邮箱等“便捷地址” | 支持 7×24 小额即时转账，并衍生二维码等服务 |

## 美洲

| 国家 | 主要系统或品牌 | 常见使用方式 | 特点 |
| --- | --- | --- | --- |
| 美国 | FedNow；RTP | 银行账号，通过银行或金融科技 App 发起 | 两套网络并存，能否使用取决于金融机构是否接入；Zelle 是银行提供的用户服务，并非 FedNow 或 RTP 的别名 |
| 巴西 | SPI；Pix | CPF/CNPJ、手机号、邮箱、随机 Pix Key、二维码 | 由巴西央行推动，个人转账和商户收款高度普及，并支持定期、自动和近场等扩展场景 |
| 墨西哥 | SPEI；CoDi、DiMo | CLABE/银行卡号、手机号、二维码 | SPEI 是实时转账基础设施；CoDi 和 DiMo 分别强化二维码及手机号体验 |
| 阿根廷 | Transferencias 3.0 / Immediate Transfers | 账号别名、CVU/CBU、二维码 | 银行和电子钱包可通过统一二维码网络互操作 |
| 哥伦比亚 | Transfiya、Entre Cuentas；Bre-B | 手机号、别名、二维码 | 市场正从多套服务向央行推动的可互操作即时支付体系演进 |
| 智利 | Transferencias en Línea（TEF） | 银行账号转账 | 线上银行转账成熟，用户体验主要由各家银行提供 |

加拿大的 Real-Time Rail（RTR）长期处于建设和调整阶段。在实际使用前，应查看 Payments Canada 的最新上线安排，不要把 Interac e-Transfer 与尚未全面投产的 RTR 混为一谈。

## 大洋洲

| 国家 | 主要系统或品牌 | 常见使用方式 | 特点 |
| --- | --- | --- | --- |
| 澳大利亚 | New Payments Platform（NPP）；Osko | PayID（手机号、邮箱、ABN 等）、银行账号 | NPP 是底层平台，Osko 是其上的早期消费级服务；银行 App 也可能直接称为 PayID 或即时转账 |
| 新西兰 | 365 日支付基础设施；银行转账 | 银行账号 | 银行间支付已覆盖全年处理，但具体速度和产品能力需看参与银行 |

## 中东与非洲

| 国家或地区 | 主要系统或品牌 | 常见使用方式 | 特点 |
| --- | --- | --- | --- |
| 沙特阿拉伯 | sarie | IBAN、手机号等 | 支持全年实时转账和别名查询 |
| 阿联酋 | Aani | 手机号、邮箱、二维码、付款请求 | 由 Al Etihad Payments 运营，逐步连接当地银行和钱包 |
| 巴林 | Fawri+ | IBAN、手机号等 | EFTS 下的即时转账服务 |
| 埃及 | Instant Payment Network；InstaPay | 银行账号、手机号、即时支付地址 | InstaPay 是面向用户的主要入口 |
| 尼日利亚 | NIBSS Instant Payment（NIP） | 银行账号、USSD、银行或金融科技 App | 非洲较早的大规模即时支付网络之一 |
| 肯尼亚 | PesaLink | 银行账号、手机号 | 连接银行账户；M-Pesa 则是独立但影响更广的移动货币体系 |
| 南非 | PayShap；RTC | ShapID（通常绑定手机号）、银行账号 | PayShap 面向低额即时支付和易记别名 |
| 坦桑尼亚 | TIPS | 手机号、钱包或银行 App | 强调银行与移动货币运营商之间的互操作 |

## 跨境即时支付

即时支付网络大多首先服务本币境内交易，但跨境互联正在增加。例如：

- 新加坡 PayNow 已与泰国 PromptPay、印度 UPI 等网络建立连接；
- 东南亚多国央行正在推动二维码和即时支付互联；
- 欧洲的 SCT Inst 天然覆盖多个 SEPA 国家和地区，但只处理符合方案规则的欧元转账；
- 国际清算银行创新中心的 Nexus 等项目尝试用统一连接方式降低各国系统逐一对接的复杂度。

“几秒到账”不代表全球系统已经完全互通。跨境支付仍可能涉及换汇、额度、合规检查、参与银行范围和接收方费用。

## 使用时的风险

即时支付通常采用 **push payment**：付款人主动授权后，资金立即进入对方账户，往往难以撤回。付款前应：

1. 核对收款人姓名以及手机号、别名或账号；
2. 首次向陌生人或大额付款时先转一笔小额测试；
3. 不因“安全账户”“退款验证”或“屏幕共享指导”而转账；
4. 发现诈骗后立即联系付款机构，并保留交易编号和沟通记录；
5. 不把“银行能追踪”误解成“银行一定能追回”。

## 资料来源与继续查询

- [世界银行 Project FASTT：全球快速支付系统追踪器](https://fastpayments.worldbank.org/)
- [国际清算银行：全球快速支付的区域比较](https://www.bis.org/publ/bppdf/bispap152.pdf)
- [欧洲中央银行：什么是即时支付](https://www.ecb.europa.eu/paym/retail/instant_payments/html/index.en.html)
- [欧洲中央银行：欧盟即时支付法规与实施时间表](https://www.ecb.europa.eu/paym/retail/instant_payments/html/instant_payments_regulation.en.html)
- [美国联邦储备金融服务：FedNow 简介](https://www.frbservices.org/financial-services/fednow/about.html)

各系统的额度、费用、覆盖银行和跨境连接会变化。实际付款前，应再查当地央行、系统运营方或开户机构的最新说明。
