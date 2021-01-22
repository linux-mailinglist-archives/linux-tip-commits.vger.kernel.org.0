Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68968300499
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Jan 2021 14:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbhAVNyp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Jan 2021 08:54:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54310 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbhAVNyn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Jan 2021 08:54:43 -0500
Date:   Fri, 22 Jan 2021 13:53:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611323640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LS1rEq+mnlPMEIZD5rTqAggEQ+60mY8o1tMF4+zn59k=;
        b=m/VQuCNrlQg8YvhVvvXfnw96IDPYlielkEj5swm2pVW7fU7quq/16NiRSwxYK32dGiTqK+
        HdEq4NP9ZYmp7mCm2xalJeKt87vm2yFQjAVh+NZ8NLnRnsZYeF0SVc8dUXg55gRHGTYQLj
        fKwUIRhcKUiDqQYhTJSSwTiOJi+IwMJps7bDmmw/v03jfjrmH/e0OwTUfXiDTFlIA8acc1
        N8BtbFteW/7yxsTMwv96vdWerLY/+6IQQ2jGHryX74ue3ARnlNaK9eLS3ML6qUu6eqT4Mt
        /Mi9LaKUX9UqwRSZapAeoW3DmYMl0XPuKxvQqF0KNkiofzJyIJgBVSzH1ykU2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611323640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LS1rEq+mnlPMEIZD5rTqAggEQ+60mY8o1tMF4+zn59k=;
        b=HEZtEMbRBAW/nqu3XKGcKcNKQogVQ8YL3xpM31DHxnL1IX9EZpy5mHQX6DxboNsQfxzuD2
        W2tN5f6fGud2tgDg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Don't fail the kernel build on fatal errors
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161132363990.414.11253215020710089846.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     655cf86548a3938538642a6df27dd359e13c86bd
Gitweb:        https://git.kernel.org/tip/655cf86548a3938538642a6df27dd359e13c86bd
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Thu, 14 Jan 2021 16:32:42 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Thu, 21 Jan 2021 15:49:39 -06:00

objtool: Don't fail the kernel build on fatal errors

This is basically a revert of commit 644592d32837 ("objtool: Fail the
kernel build on fatal errors").

That change turned out to be more trouble than it's worth.  Failing the
build is an extreme measure which sometimes gets too much attention and
blocks CI build testing.

These fatal-type warnings aren't yet as rare as we'd hope, due to the
ever-increasing matrix of supported toolchains/plugins and their
fast-changing nature as of late.

Also, there are more people (and bots) looking for objtool warnings than
ever before, so even non-fatal warnings aren't likely to be ignored for
long.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5f8d3ee..4bd3031 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2928,14 +2928,10 @@ int check(struct objtool_file *file)
 	warnings += ret;
 
 out:
-	if (ret < 0) {
-		/*
-		 *  Fatal error.  The binary is corrupt or otherwise broken in
-		 *  some way, or objtool itself is broken.  Fail the kernel
-		 *  build.
-		 */
-		return ret;
-	}
-
+	/*
+	 *  For now, don't fail the kernel build on fatal warnings.  These
+	 *  errors are still fairly common due to the growing matrix of
+	 *  supported toolchains and their recent pace of change.
+	 */
 	return 0;
 }
