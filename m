Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD31807D65
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Dec 2023 01:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjLGApN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 Dec 2023 19:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjLGApM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 Dec 2023 19:45:12 -0500
Received: from lhr.gtn-esa2.in (gtnesa2.ptcl.net [59.103.87.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EBE418D
        for <linux-tip-commits@vger.kernel.org>; Wed,  6 Dec 2023 16:45:17 -0800 (PST)
Message-Id: <573856$1hrkqj@lhr.gtn-esa2.in>
X-IPAS-Result: =?us-ascii?q?A2HuBwBDFHFl/7FksbYNTR4BPAwCCxUJgUUDgU8CAQEBA?=
 =?us-ascii?q?YgNiB+nRYF9DwEBAQEBAQEBAR0THQQBAYUBAwKHLSc8Ag0BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBAQUBAQEBAQEGAwEBAQKBGYUvgwWEDic6HCgNAiYCSRa0KXqBM?=
 =?us-ascii?q?hpnhF+xTiwDAQEBAQGBY4YlAYFQhAiENo9qFYJTBJ99BwIFcEdwGwMHA38PK?=
 =?us-ascii?q?wcELSIGCRQtIwZRBCghCRMSPgQwO4JECoECPw8OEYI9KzY2GUiCWxUMNEp1E?=
 =?us-ascii?q?EIXgRFuGxMeNxESFw0DCHQdAjI8AwUDBDMKEg0LIQVWA0UGSQsDAhoFAwMEg?=
 =?us-ascii?q?TMFDR4CECwnAwMSSQIQFAM7AwMGAwsxAzCBGQxPA2sfNgk8DwwfAjkNJyMCL?=
 =?us-ascii?q?FYFEgIWAyQaNhEJCxgQAy8GOwITDAYGCV4mFgIHBCcDCAQDXwMPAzMRHTcJA?=
 =?us-ascii?q?3g9NQgMG0QIRx0SphmCR5YyjAGBa6BOBwOpVgGTXgOEGo4ch3+QQyCkdoVTg?=
 =?us-ascii?q?WiEKFGiRoEkAgcLAQEDCYkigUABAQ?=
IronPort-PHdr: A9a23:iyZp6RXIwmcYbP//JALPRUfKVsfV8KxAUjF92vMcY1JmTK2v8tzYM
 VDF4r011RmVB9WdsqIdwLCN+4nbGkU+or+580o+OKRWUBEEjchE1ycBO+WiTXPBEfjxciYhF
 95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba1xI
 RmssAnctdQajYR8Jqs/1xDEvmZGd+NKyGxnIl6egwzy6sCs8pB97i9eoegh98lOUaX7e6Q3U
 7lVByk4Pm42+cPmqwDNQROA6XUAXGoWlAFIAxXe4xHhQpjxqCr6ufFj1yScIMb7UKo7WTWm7
 6dsVR/olCIKPCM3/W3LlsB9ir9QrxW9qhFx34LYfZiZOOZjcqjAed8WWGpMUsNXWidcAI2zc
 pEPAvIdMulXoIfzukUAoxugCAeiHuPi0SNIhmbq0aEmz+gtDQPL0Qo9FNwOqnTUq9D1Ob8cX
 e6o1qbIyC/PYu9Y1Tr69IXIaBEhof+WUbx1ccre008vGhjdjlWMtYPlOymZ1uITvGiH9eZgT
 eGvhnchpgpsrTeh2t0ihZPVhoIJ1F/E7yN5zZ40KNC8SEB1bt+pHpVMuyyYOIV7QMwvTm5pt
 Ss0yrMKpYC2cDUXxJg62hLSZOGLfouH7xzjSuucLjl2inx4db+igRu57EuuyvXkW8Wp01tGs
 DBJnsTOu30PzRDf99SLRudn8ku82zuC1Qbe4fxZL0Asj6XbLoIswroolpoTq0vNAzL2l170j
 KCIakok5vCl5P7pY7r8p5+cK450igfxMqUuncy/HP44MhIQUGiA4eS807vj/VbnT7hMk/Y7j
 K3ZsI3BJcQHuKG5GRJb0oci6hmhFzqr09cVkHkBIVlYYhyIlZLpNEvLIP3gCPe/hEmjnylzy
 vDdO73hHo3NLn/ekLf9Zbp961BTyA40zd1H451YF7UMLOzpVkPstdHVDQU1PxGuz+r5Ftlw1
 oURVXqOAq+fLqzSrUeF6v8sLuWSfoMZpTTwJvo/6/LzkXM1hUURcbSr0JYVcHy4G+5pI0SdY
 XrimNcBFmIKsxIiQezwiV2CXyRfaXOyX60m4DE2E5qmDZvfSYCpmrCB2jm0HoFMamBeCVCAC
 XHoeJ6cVPcWdC2SOtNhkiADVbW5VoMs0QmitBXmxLp/MurU5ioYuIrk1Nh1+uHelx4/+CdsD
 8SAyWGCUnx0kX0SSzAowa9/vFRxyk2f3qhgn/xYCdtT6utRUgggL57czO13B83sVg/aZteJV
 UymTci7AT4vVN4+3cIBY1tlF9W4kh/DxzaqA6MSl7GTB5w086fc02X+Kspgy3vLz7Ehj0Q8Q
 sRSKG2pmLRz+BbOCI7Ui0mZjbqldbwA3C7R82eO1W6Os19GXwJtUKjIXnMSa1DOrdTk/EPNU
 qKuBqo9PgRf1MGCN7NGasf1glVeWPfjJNPebnqqm2ewBBaIwK6AYYv2d2gGxCXdFVIEnB0O/
 XmYLwQxGDquo3+NRABpQBjzZEaq6vRxqWKyS0Yc0wGJKUZmkbitsFZBrOadRbUw3rsCkD89o
 DEyGluhmcrVXYm6qhJlbZlbNMw85FNG3GfC7l0jZrSrN6Ykh0JNXR5wuhak7BxyTKwKxeEwr
 X1s7wp7L4qAzFhFMTWVwdboOeuEeSHJ4BmzZvuOiRnl29GM9/JWtZwF
IronPort-Data: A9a23:eE9D7KohlGtxQknjnAZNQKpEzFNeBmISZRIvgKrLsJaIsI4StFCzt
 garIBmBOqzZY2P3Kt5watvjoB8G6J+DztdrGwpq+Hs1Rn8S8JacVYWSI27OZC7DdceroGCLT
 ik9hnssCOhuExcwcz/0auCJQUFUjP3OHvymYAL9EngZqTVMEU/Nsjo93bZl6mJUqYLhWVjU4
 4us+5a31GKNglaYDEpFs8pvlzsy5JweiBtA1rDpTakW1LN2vyB94KM3fcldHVOhKmVnNrfSq
 9L48V2M1jixEyHBqD+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRa1hIg+ZzihxrhMJ
 NtxWZOYWSMrL7PL2/UmVSZcNy59AqJtx7r4CC3q2SCT5xWun3rE8Kw/VgdvY91eo6AtWzx7n
 RAaAGldNFba2L3wmerjDLAz2azPL+GyVG8bklh6zD+fLvYvR7jbX67Oo9lVwHEohaiiGN6DP
 ZBJN2A/PXwsZTV/EQcmN5AQrN2Ql3/kUR0Eo3i2n60otj27IAtZleKF3MDuUtuKHJoJtl6Fv
 G7b8iL0DgxyHMSW0znbqyiEnvLVkT72Ho8eCdWQ9f9v2QHKm0QLFQcaSFb9rPWk4ma6Vt8Gd
 RxE0jIzt6Qv+QqmQsSVdwa4oXjd4EY0Q8dKH/A3rgyB18L86g2DC2UBQyRpcME8uNI7AzEmy
 zehk8ngBBR3raeZVH/b+7uJxRu7PykQIHQCfi4CQgtUs/HspYgyilTESdMLOLe0h9rnMSv32
 D3PrDU6grwVy8MHys2T/FzFgjuqup/hVhMv6hjaGG+p82tRYIOoPdz2tXDD8OxMMYvfQ1Wc1
 FAKh8GY4/gJCrmViTaBXehLEb20j96APDDYiFtmBbE56i6h5nPlcIxNiBl6P05oNsEeUSf0e
 kPOtEVc6II7FHWjaal+YYC4I9w316T9GJLoWu28RtlPZ4NuLSec/yJzI0OcwgjFlEkgz4k0M
 I2XcMiiS38RT7lkpBK0QOcbl6Quxzw+7WPaQJrm1Ru8zLbYb3mQIZ8FOV2Mc+QR57jCvwzO8
 9dZONeNzVNSXPCWX8XM2ddDdxZTcid9XMiu7ZUIKYZvPzZbJY3oMNeJqZtJRmCvt/09ejvgl
 p12ZqOUJJcTS5EKxcVmp02PsI/SYKs=
IronPort-HdrOrdr: A9a23:bwjxoa4YibFulC25fQPXwNjXdLJyesId70hD6qm+c3xomgXxra
 yTdZMguCMc6Qx7ZJhOo6HiBEDtexLhHP1Oi7X5VI3KNDUO3lHYTr2KhrGM/9SPIUPDytI=
X-Talos-CUID: =?us-ascii?q?9a23=3A4P9bzmmV3QZCc6y3nnRWj7p3KvTXOW35zmbOJAy?=
 =?us-ascii?q?pMmBWTJmaSmCf05xhrOM7zg=3D=3D?=
X-Talos-MUID: 9a23:xvgkdQQGG7e+m635RXTcr2FTC8VG056WGUYWs7VasOOnDytvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,256,1695668400"; 
   d="scan'208";a="52286291"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO [192.168.1.225]) ([182.177.100.177])
  by lhr.gtn-esa2.in with ESMTP; 07 Dec 2023 05:45:04 +0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: #Awaiting your response
To:     "tom.sugiyama@thk.co.jp" <Arif.Khan@ptcl.net.pk>
From:   "Sam.A" <Arif.Khan@ptcl.net.pk>
Cc:     tom.sugiyama@thk.co.jp
Date:   Thu, 07 Dec 2023 08:44:54 +0800
Reply-To: williams1960@cpn.it
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_50,FROM_MISSPACED,
        FROM_MISSP_EH_MATCH,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RCVD_IN_PSBL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [59.103.87.20 listed in list.dnswl.org]
        *  2.7 RCVD_IN_PSBL RBL: Received via a relay in PSBL
        *      [59.103.87.20 listed in psbl.surriel.com]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 RCVD_IN_MSPIKE_L3 RBL: Low reputation (-3)
        *      [59.103.87.20 listed in bl.mailspike.net]
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 RCVD_IN_MSPIKE_BL Mailspike blocklisted
        *  0.0 MSGID_FROM_MTA_HEADER Message-Id was added by a relay
        *  1.7 FROM_MISSPACED From: missing whitespace
        *  2.0 FROM_MISSP_EH_MATCH From misspaced, matches envelope
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

H e l l o,

I'm a consultant, I work with a client who is interested in entering into a joint venture corporation in your nation. He has capitals set aside for this purpose.

Kindly get in touch with me if you're interested.

Regards,
Mr. Sam A. Williams
