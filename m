Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3813582FB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Apr 2021 14:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhDHMN6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Apr 2021 08:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhDHMNz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Apr 2021 08:13:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693D8C061762;
        Thu,  8 Apr 2021 05:13:44 -0700 (PDT)
Date:   Thu, 08 Apr 2021 12:13:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617884022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jl/iDVbgDjoIROPCoDBb62Co+bvxRy+mMrB2zXmb1T0=;
        b=XTMN4lw01G4vumOWYJTU5u5yxjsIqL6oMfoXv477c9dOwd0zSiYOkaJlH9yXV4+2U9Nn9x
        wBIIG66vvhx1imVz6ihVa4hXPy8sIKkNFf1NEB9CJ753OcOGt8zmR+Iigh+RCvufr/a/hv
        C3LzUvao6USBTGRKMHTGDP4G9jubqABrlYdRULwXfv/0PCBh0Ulnnh8hzNc6VTrjQXNSl0
        3RjXjLgDOu7S1jzmIVOQJP9Wcqef6esmC6pw7mdHUoKl6USMANeVTflp4epDJam+i/zdUX
        kX0q0r+FJGYV3x0OnJIHfeyGteiingOkx+cOo93HWRYbBKP1hyQfPFXv7hcUOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617884022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jl/iDVbgDjoIROPCoDBb62Co+bvxRy+mMrB2zXmb1T0=;
        b=xb/cdHMu3zv5wFJeAhadbyKVMl7Ztckv9fehRxt+GZ9hZyrfPm6AQuwb2LW1cZCnj+SiyY
        Ir2/E2kPsV3XpmDw==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] jump_label: Provide CONFIG-driven build state defaults
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210401232347.2791257-2-keescook@chromium.org>
References: <20210401232347.2791257-2-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <161788402204.29796.3718117807122564028.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     0d66ccc1627013c95f1e7ef10b95b8451cd7834e
Gitweb:        https://git.kernel.org/tip/0d66ccc1627013c95f1e7ef10b95b8451cd7834e
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Thu, 01 Apr 2021 16:23:42 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Apr 2021 14:05:19 +02:00

jump_label: Provide CONFIG-driven build state defaults

As shown in the comment in jump_label.h, choosing the initial state of
static branches changes the assembly layout. If the condition is expected
to be likely it's inline, and if unlikely it is out of line via a jump.

A few places in the kernel use (or could be using) a CONFIG to choose the
default state, which would give a small performance benefit to their
compile-time declared default. Provide the infrastructure to do this.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210401232347.2791257-2-keescook@chromium.org

---
 include/linux/jump_label.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index d926912..05f5554 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -382,6 +382,21 @@ struct static_key_false {
 		[0 ... (count) - 1] = STATIC_KEY_FALSE_INIT,	\
 	}
 
+#define _DEFINE_STATIC_KEY_1(name)	DEFINE_STATIC_KEY_TRUE(name)
+#define _DEFINE_STATIC_KEY_0(name)	DEFINE_STATIC_KEY_FALSE(name)
+#define DEFINE_STATIC_KEY_MAYBE(cfg, name)			\
+	__PASTE(_DEFINE_STATIC_KEY_, IS_ENABLED(cfg))(name)
+
+#define _DEFINE_STATIC_KEY_RO_1(name)	DEFINE_STATIC_KEY_TRUE_RO(name)
+#define _DEFINE_STATIC_KEY_RO_0(name)	DEFINE_STATIC_KEY_FALSE_RO(name)
+#define DEFINE_STATIC_KEY_MAYBE_RO(cfg, name)			\
+	__PASTE(_DEFINE_STATIC_KEY_RO_, IS_ENABLED(cfg))(name)
+
+#define _DECLARE_STATIC_KEY_1(name)	DECLARE_STATIC_KEY_TRUE(name)
+#define _DECLARE_STATIC_KEY_0(name)	DECLARE_STATIC_KEY_FALSE(name)
+#define DECLARE_STATIC_KEY_MAYBE(cfg, name)			\
+	__PASTE(_DECLARE_STATIC_KEY_, IS_ENABLED(cfg))(name)
+
 extern bool ____wrong_branch_error(void);
 
 #define static_key_enabled(x)							\
@@ -482,6 +497,10 @@ extern bool ____wrong_branch_error(void);
 
 #endif /* CONFIG_JUMP_LABEL */
 
+#define static_branch_maybe(config, x)					\
+	(IS_ENABLED(config) ? static_branch_likely(x)			\
+			    : static_branch_unlikely(x))
+
 /*
  * Advanced usage; refcount, branch is enabled when: count != 0
  */
