Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BA333C064
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhCOPs0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbhCOPsB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:48:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4103EC0613DE;
        Mon, 15 Mar 2021 08:47:52 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:47:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0fTOaiQdK2nqgdDLkFLGO7n8Rdikn3bjO40MXZPrt7k=;
        b=Lox4Uw6peksqmc4J/ZGvjHsTJZ1QNR/7B0Cv7K5nLKiCVnQ5ZoWYr4q+WIQqotUhxc4mgM
        TS/xtZZKfiRjhtvqK4w46mgsoYTvFT25ue2UGDCnAZBlm3Cn5PEtV8w8hJomkLsbnRzNXF
        k8xNbvNhjQ1bah20jyQv383csauKlO/6BQU8UQrKNZnnvG1Y2D32gkVhNpT7EDt1F532l+
        JXs9NLIXYz4+XDSUwyvn/xKJetb8lcmyg0O2AXOweVswTL7N5mWancfuiw8BgRXPm4tefY
        wU6cuUcOzU884nJtV/fhbqxXnMwCLbh9fEdAZGffFOXTuTkLcqiWHRtEiA2tCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0fTOaiQdK2nqgdDLkFLGO7n8Rdikn3bjO40MXZPrt7k=;
        b=PFRfhvKT0+uEtupSFXSr+YmFfWPgUd3Uc4LOPE2YXIPt9PYwcVvMCnUgM1BS7glHITtKJ5
        gBcaX6xCa77GGvCA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] perf/x86/intel/ds: Check return values of insn
 decoder functions
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-9-bp@alien8.de>
References: <20210304174237.31945-9-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326782.398.3184167624440051970.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     8c98a605544cfdec21d32fcf8fc855dc439f608f
Gitweb:        https://git.kernel.org/tip/8c98a605544cfdec21d32fcf8fc855dc439f608f
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 06 Nov 2020 16:36:24 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 11:23:48 +01:00

perf/x86/intel/ds: Check return values of insn decoder functions

branch_type() doesn't need to call the full insn_decode() because it
doesn't need it in all cases thus leave the calls separate.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210304174237.31945-9-bp@alien8.de
---
 arch/x86/events/intel/lbr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 21890da..9ecf502 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1224,8 +1224,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 	is64 = kernel_ip((unsigned long)addr) || any_64bit_mode(current_pt_regs());
 #endif
 	insn_init(&insn, addr, bytes_read, is64);
-	insn_get_opcode(&insn);
-	if (!insn.opcode.got)
+	if (insn_get_opcode(&insn))
 		return X86_BR_ABORT;
 
 	switch (insn.opcode.bytes[0]) {
@@ -1262,8 +1261,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 		ret = X86_BR_INT;
 		break;
 	case 0xe8: /* call near rel */
-		insn_get_immediate(&insn);
-		if (insn.immediate1.value == 0) {
+		if (insn_get_immediate(&insn) || insn.immediate1.value == 0) {
 			/* zero length call */
 			ret = X86_BR_ZERO_CALL;
 			break;
@@ -1279,7 +1277,9 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 		ret = X86_BR_JMP;
 		break;
 	case 0xff: /* call near absolute, call far absolute ind */
-		insn_get_modrm(&insn);
+		if (insn_get_modrm(&insn))
+			return X86_BR_ABORT;
+
 		ext = (insn.modrm.bytes[0] >> 3) & 0x7;
 		switch (ext) {
 		case 2: /* near ind call */
