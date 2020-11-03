Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDBD2A503B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Nov 2020 20:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgKCTfb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 3 Nov 2020 14:35:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbgKCTfb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 3 Nov 2020 14:35:31 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3JXGsj054334;
        Tue, 3 Nov 2020 14:35:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ut4uE+NvWkQTsIff4jbZGEfGEKX/xUUur0h37SibtEA=;
 b=RG3PBwyul0XWWp5Wsi9Q51/OJBf3epruopOWq3Z5FB/EQERDo5Gd5ipXSVa/8sYpX6RQ
 kWEskz6/x5TtjWTPQdIoNmGVawXUuKXLIaZGOo8LF7ses5tIPVH9l7XpAzaI2ypMFT2t
 CjLHKUgwGWe/tY4w/S9G5eg8e5889/iFU7i+lxfLW+6UPXCBjLCgqs6kYDZOaTFfBylM
 xG99z87XLOR8NprcVSlvFTFfyHOuRCcLRmpZcFBfijSlzCrc2UZCKTHmllMZPi5CVQx+
 HciXDRtOlgI8TF6XLzAEL681qkEZ7tgenXCn4ASAThGmyocpToKPxuM49qcSGIpgnkvc mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34kbppbdya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 14:35:25 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A3JXVe2055054;
        Tue, 3 Nov 2020 14:35:24 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34kbppbdvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 14:35:24 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3JRXrg024180;
        Tue, 3 Nov 2020 19:35:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 34hm6hattu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 19:35:17 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A3JZFDx6357506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Nov 2020 19:35:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D7F6A4054;
        Tue,  3 Nov 2020 19:35:15 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1463A405B;
        Tue,  3 Nov 2020 19:35:14 +0000 (GMT)
Received: from localhost (unknown [9.145.42.130])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Nov 2020 19:35:14 +0000 (GMT)
Date:   Tue, 3 Nov 2020 20:35:09 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86 <x86@kernel.org>
Subject: [PATCH 1/1] x86/tools: Use tools headers for instruction decoder
 selftests
Message-ID: <patch-1.thread-59328d.git-59328d9dc2b9.your-ad-here.call-01604429777-ext-1374@work.hours>
References: <20201014162859.987d5f71f5e5456ffb812abc@kernel.org>
 <cover.thread-59328d.your-ad-here.call-01604429777-ext-1374@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-59328d.your-ad-here.call-01604429777-ext-1374@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_08:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 suspectscore=1 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030130
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Currently x86 instruction decoder is used from:
- the kernel itself
- from tools like objtool and perf
- within x86 tools, i.e. instruction decoder selftests

The first two cases are similar, because tools headers try to mimic
kernel headers.

Instruction decoder selftests include some of the kernel headers
directly, including uapi headers. This works until headers dependencies
are kept to minimum and tools are not cross-compiled. Since the goal of
the x86 instruction decoder selftests is not to verify uapi headers move
it to using tools headers, like this is already done for vdso2c tool,
mkpiggy and other tools in arch/x86/boot/.

This effectively fixes x86 kernel cross-compilation with
CONFIG_X86_DECODER_SELFTEST=y. And posttests are run successfully at
least on s390.

Fixes: 2a522b53c470 ("x86/insn: Support big endian cross-compiles")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 Based on jpoimboe/objtool/core

 arch/x86/tools/Makefile      | 8 ++++----
 arch/x86/tools/insn_sanity.c | 4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/tools/Makefile b/arch/x86/tools/Makefile
index 55b1ab378974..bddfc9a46645 100644
--- a/arch/x86/tools/Makefile
+++ b/arch/x86/tools/Makefile
@@ -29,14 +29,14 @@ posttest: $(obj)/insn_decoder_test vmlinux $(obj)/insn_sanity
 hostprogs += insn_decoder_test insn_sanity
 
 # -I needed for generated C source and C source which in the kernel tree.
-HOSTCFLAGS_insn_decoder_test.o := -Wall -I$(objtree)/arch/x86/lib/ -I$(srctree)/arch/x86/include/uapi/ -I$(srctree)/arch/x86/include/ -I$(srctree)/arch/x86/lib/ -I$(srctree)/include/uapi/
+HOSTCFLAGS_insn_decoder_test.o := -Wall -I$(srctree)/tools/arch/x86/lib/ -I$(srctree)/tools/arch/x86/include/ -I$(objtree)/arch/x86/lib/
 
-HOSTCFLAGS_insn_sanity.o := -Wall -I$(objtree)/arch/x86/lib/ -I$(srctree)/arch/x86/include/ -I$(srctree)/arch/x86/lib/ -I$(srctree)/include/
+HOSTCFLAGS_insn_sanity.o := -Wall -I$(srctree)/tools/arch/x86/lib/ -I$(srctree)/tools/arch/x86/include/ -I$(objtree)/arch/x86/lib/
 
 # Dependencies are also needed.
-$(obj)/insn_decoder_test.o: $(srctree)/arch/x86/lib/insn.c $(srctree)/arch/x86/lib/inat.c $(srctree)/arch/x86/include/asm/inat_types.h $(srctree)/arch/x86/include/asm/inat.h $(srctree)/arch/x86/include/asm/insn.h $(objtree)/arch/x86/lib/inat-tables.c
+$(obj)/insn_decoder_test.o: $(srctree)/tools/arch/x86/lib/insn.c $(srctree)/tools/arch/x86/lib/inat.c $(srctree)/tools/arch/x86/include/asm/inat_types.h $(srctree)/tools/arch/x86/include/asm/inat.h $(srctree)/tools/arch/x86/include/asm/insn.h $(objtree)/arch/x86/lib/inat-tables.c
 
-$(obj)/insn_sanity.o: $(srctree)/arch/x86/lib/insn.c $(srctree)/arch/x86/lib/inat.c $(srctree)/arch/x86/include/asm/inat_types.h $(srctree)/arch/x86/include/asm/inat.h $(srctree)/arch/x86/include/asm/insn.h $(objtree)/arch/x86/lib/inat-tables.c
+$(obj)/insn_sanity.o: $(srctree)/tools/arch/x86/lib/insn.c $(srctree)/tools/arch/x86/lib/inat.c $(srctree)/tools/arch/x86/include/asm/inat_types.h $(srctree)/tools/arch/x86/include/asm/inat.h $(srctree)/tools/arch/x86/include/asm/insn.h $(objtree)/arch/x86/lib/inat-tables.c
 
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 hostprogs	+= relocs
diff --git a/arch/x86/tools/insn_sanity.c b/arch/x86/tools/insn_sanity.c
index 185ceba9d289..c6a0000ae635 100644
--- a/arch/x86/tools/insn_sanity.c
+++ b/arch/x86/tools/insn_sanity.c
@@ -14,10 +14,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-
-#define unlikely(cond) (cond)
-#define ARRAY_SIZE(a)	(sizeof(a)/sizeof(a[0]))
-
 #include <asm/insn.h>
 #include <inat.c>
 #include <insn.c>
-- 
2.25.4
