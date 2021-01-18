Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CB02FAC01
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Jan 2021 22:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389944AbhARU7l (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 18 Jan 2021 15:59:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55304 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389761AbhARKOi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 18 Jan 2021 05:14:38 -0500
Date:   Mon, 18 Jan 2021 10:13:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610964813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=N200xvYKaDL7tHm8Rzwrr0HU1/brDxR7TTDvWBDPLPY=;
        b=m9AYFj5VAUrZGPnVhJRAn1+6dNN+lQWQ/sjdgozJ4mG5yHgiXNXaVQ936EmR7LZxBDXtdV
        5+OCVCryVglIv8EqHZmert6+9NhNrtfK96ngpvwmYZUBmQWOva+CdMceH72HTFKUyNwDo6
        1mVqhcqhRs24eGne/8u9rm3DIMDEhssgvPqSezaxmjf+UUDcAKdujEZKu1T20sZD6Jn3pt
        QdIPFmCGMoIx/jdl3Yf0cH+R7fQ5509fQtLuVt0NJYvRIyViCDIo7JoqttRtX92/7QDzXd
        W5ZgTxlYosZYDNJIq7G/3Ln9KnhOkvTBhSHelpM36Qra5BxmXQvBfXFGmI59+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610964813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=N200xvYKaDL7tHm8Rzwrr0HU1/brDxR7TTDvWBDPLPY=;
        b=TY2TIpagEQcRsbJCWn4zRHflORQYn1Vb5X4junA8NW3sXszMZ+5WcZTttd386LamVReBXL
        +OgAfbOIQX6OEDAQ==
From:   "tip-bot2 for Vasily Gorbik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/tools: Use tools headers for instruction
 decoder selftests
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161096481258.414.12537383171975793205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c8d7b7e592f471ec1da39d872dc6bbf767a812e7
Gitweb:        https://git.kernel.org/tip/c8d7b7e592f471ec1da39d872dc6bbf767a812e7
Author:        Vasily Gorbik <gor@linux.ibm.com>
AuthorDate:    Fri, 13 Nov 2020 00:03:20 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Wed, 13 Jan 2021 18:13:11 -06:00

x86/tools: Use tools headers for instruction decoder selftests

Currently the x86 instruction decoder is used from:
- the kernel itself,
- from tools like objtool and perf,
- within x86 tools, i.e. instruction decoder selftests.

The first two cases are similar, because tools headers try to mimic
kernel headers.

Instruction decoder selftests include some of the kernel headers
directly, including uapi headers. This works until headers dependencies
are kept to a minimum and tools are not cross-compiled. Since the goal
of the x86 instruction decoder selftests is not to verify uapi headers,
move it to using tools headers, like is already done for vdso2c tool,
mkpiggy and other tools in arch/x86/boot/.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/tools/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/tools/Makefile b/arch/x86/tools/Makefile
index 55b1ab3..bddfc9a 100644
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
