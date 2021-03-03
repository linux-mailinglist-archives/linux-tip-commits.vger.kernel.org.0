Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E655432C7AB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386135AbhCDAcb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842997AbhCCKXd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B562C061A30;
        Wed,  3 Mar 2021 00:45:37 -0800 (PST)
Date:   Wed, 03 Mar 2021 08:45:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614761135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4ljjq/lCJeQqCSOfFsXrW35464hWKxh/o/GjmGAwm0=;
        b=xChM4BwLZAY1Vpf0rHUWqAtLCoa+zZ1gRWa9UqFlcodH44zKUN+loTu+XT701zyNG9o+zA
        oYwvExXEl4Kldl3mxsJbhSVQspqOXhwSa19AictotEcNsa1qQQDwk+DmsGiHVA6qwuAxHt
        MNhyU/9TJ++YJLbl7VFGiTurjgDaIT8VIXa/G1gSqHaCprhh+Zg3glooNJU81H1Cj1/r2V
        p9kzTLdU9MAn7uXRq++swHFWJsCRrnZn7aMnIsY+F5Q9raiuZ3vw0zON9gtE1a663w7fkM
        ismk0MPRAn4fHnP3CjIqU1MVA8cJc0WLde3ybpXWgZpa+4xP/8SN2BGCP9J4uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614761135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4ljjq/lCJeQqCSOfFsXrW35464hWKxh/o/GjmGAwm0=;
        b=qrpEd3hsTdCvXbIOBWJbVyFHjTrsdNoPFLo4YjZQM6tHpRJz2UiTTjxciy5lzvQBCGduj5
        5TJqUj1bktRAa+Aw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool,x86: Renumber CFI_reg
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210211173627.033720313@infradead.org>
References: <20210211173627.033720313@infradead.org>
MIME-Version: 1.0
Message-ID: <161476113489.20312.7284325653079274209.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     5e506daa2d148f735f90b2018ca6ef6e52144fad
Gitweb:        https://git.kernel.org/tip/5e506daa2d148f735f90b2018ca6ef6e52144fad
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 09 Feb 2021 20:18:21 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 09:38:29 +01:00

objtool,x86: Renumber CFI_reg

Make them match the instruction encoding numbering.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lkml.kernel.org/r/20210211173627.033720313@infradead.org
---
 tools/objtool/arch/x86/include/arch/cfi_regs.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/arch/x86/include/arch/cfi_regs.h b/tools/objtool/arch/x86/include/arch/cfi_regs.h
index 79bc517..0579d22 100644
--- a/tools/objtool/arch/x86/include/arch/cfi_regs.h
+++ b/tools/objtool/arch/x86/include/arch/cfi_regs.h
@@ -4,13 +4,13 @@
 #define _OBJTOOL_CFI_REGS_H
 
 #define CFI_AX			0
-#define CFI_DX			1
-#define CFI_CX			2
+#define CFI_CX			1
+#define CFI_DX			2
 #define CFI_BX			3
-#define CFI_SI			4
-#define CFI_DI			5
-#define CFI_BP			6
-#define CFI_SP			7
+#define CFI_SP			4
+#define CFI_BP			5
+#define CFI_SI			6
+#define CFI_DI			7
 #define CFI_R8			8
 #define CFI_R9			9
 #define CFI_R10			10
