Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B33933C068
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhCOPs3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhCOPsB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:48:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE8DC0613DD;
        Mon, 15 Mar 2021 08:47:52 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:47:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jd3cUXXBjFlUuLZpzU3KrGQa5f3RjuZDLw0An3ISAfE=;
        b=rkHIfOCwL5zLLHoEdSA4ACSoSoN3MeuX8+krrYqHSuBUlNweE0mup3r2xTK0ll5CBSz7l+
        TIKiExn0pqJb8inW4AgtOBWyRui0FMUCl4bzINHYmkaa+MfWt1LQOtNXrrZ4osUmxi/SoM
        JtwgLEKriRJZss8q92RKjO28+nxn44+Qm2SETT0D5q/s94SYZv4EifAY3K8MezsozST4FZ
        H/PlHGTTFDTN9frQP5EBOdZopKPzeEtGXnyAsYm/QBb6tBb1k8V9ytXUMauKbUJczztWUA
        M4OvwR6HHAw+tKcvs1r7vAOp3O+Y5ss6V7AKJXjeP9cln7xvoAeKBJFTu9U4Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jd3cUXXBjFlUuLZpzU3KrGQa5f3RjuZDLw0An3ISAfE=;
        b=6CFlvhfIHhJc7Dcubw3wE/IovrR0SfGAPTObomn+Iom6STx3Ea9c1zH01SoE9lMb0YQWIU
        4kr6ScqtUSJbhxAQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] perf/x86/intel/ds: Check insn_get_length() retval
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-8-bp@alien8.de>
References: <20210304174237.31945-8-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326807.398.8470473732689002593.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     2ff49881d606d5e0d5b27cb6066c8a18689bd341
Gitweb:        https://git.kernel.org/tip/2ff49881d606d5e0d5b27cb6066c8a18689bd341
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 06 Nov 2020 16:33:34 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 11:20:29 +01:00

perf/x86/intel/ds: Check insn_get_length() retval

intel_pmu_pebs_fixup_ip() needs only the insn length so use the
appropriate helper instead of a full decode. A full decode differs only
in running insn_complete() on the decoded insn but that is not needed
here.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210304174237.31945-8-bp@alien8.de
---
 arch/x86/events/intel/ds.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7ebae18..cdd195a 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1353,14 +1353,13 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
 		is_64bit = kernel_ip(to) || any_64bit_mode(regs);
 #endif
 		insn_init(&insn, kaddr, size, is_64bit);
-		insn_get_length(&insn);
+
 		/*
-		 * Make sure there was not a problem decoding the
-		 * instruction and getting the length.  This is
-		 * doubly important because we have an infinite
-		 * loop if insn.length=0.
+		 * Make sure there was not a problem decoding the instruction.
+		 * This is doubly important because we have an infinite loop if
+		 * insn.length=0.
 		 */
-		if (!insn.length)
+		if (insn_get_length(&insn))
 			break;
 
 		to += insn.length;
