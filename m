Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8602FAC03
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Jan 2021 22:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390514AbhARU7m (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 18 Jan 2021 15:59:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389764AbhARKOi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 18 Jan 2021 05:14:38 -0500
Date:   Mon, 18 Jan 2021 10:13:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610964813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+ASOL/HUcXT0Ylb7pBBnIWCkuW9iIUMnFxk/hpocQG0=;
        b=dvVypYVjnNjBNPDjHHXgWAIq1RtM5gJabaCuCAFBsSwqR1Yis25mCff5BBsilNgSgEb2lM
        RMi+RGsZIcv/tTVYWZvXLQQrVqyayr2Y2O00AuP9HlYGUNUHha0+gqCR5qziBEicPhDvZw
        ZlnyxF4IdwXqTeTJSh5mTcbg7de3O8F/1VKD4MENC8P1ODrbyuu8R7TjrWukEXDoJ6N95+
        PItz+obVBvPFQnSJrE0cDAeMXaVFef2pcfh0Ig56NkPPQIyUSaguqDpHqw822I/9jwqtft
        u70diq3362uMYgtKUU1wktTwT8JYWiotsYLyv4qUEBb0KL9l5pKq627PAInUiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610964813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+ASOL/HUcXT0Ylb7pBBnIWCkuW9iIUMnFxk/hpocQG0=;
        b=Fcpt5yI4beLXtF05MqvOcFQPfc4hrEctYiK/gWdxkAnUOkmOSGQMYT0rcCA4d1AeFBQK+s
        np/A1CmswvPAGBCQ==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Support addition to set CFA base
Cc:     Julien Thierry <jthierry@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161096481293.414.7918792110016452403.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     468af56a7bbaa626da5a4578bedc930d731fba13
Gitweb:        https://git.kernel.org/tip/468af56a7bbaa626da5a4578bedc930d731fba13
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Wed, 14 Oct 2020 08:38:01 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Wed, 13 Jan 2021 18:13:10 -06:00

objtool: Support addition to set CFA base

On arm64, the compiler can set the frame pointer either
with a move operation or with and add operation like:

    add (SP + constant), BP

For a simple move operation, the CFA base is changed from SP to BP.
Handle also changing the CFA base when the frame pointer is set with
an addition instruction.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 88210b0..00d00f9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1960,6 +1960,17 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 				break;
 			}
 
+			if (!cfi->drap && op->src.reg == CFI_SP &&
+			    op->dest.reg == CFI_BP && cfa->base == CFI_SP &&
+			    check_reg_frame_pos(&regs[CFI_BP], -cfa->offset + op->src.offset)) {
+
+				/* lea disp(%rsp), %rbp */
+				cfa->base = CFI_BP;
+				cfa->offset -= op->src.offset;
+				cfi->bp_scratch = false;
+				break;
+			}
+
 			if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
 
 				/* drap: lea disp(%rsp), %drap */
