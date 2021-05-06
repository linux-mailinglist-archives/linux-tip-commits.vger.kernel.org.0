Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D66A37537F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 14:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhEFMPJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 08:15:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38664 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbhEFMPF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 08:15:05 -0400
Date:   Thu, 06 May 2021 12:14:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620303246;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9P2kEhmr0i0YWJR71NrYPfolA7iSiSQtq+MyDZhViQ=;
        b=r74zZXWCgoMvofpAByx0O7Laah6ZPPYd0VWDKLGluVnS/Gv58v3WXl3rZBx8Qp8yghOglF
        L+hPQR8Ce3FU9kjREY2ejmOiNEtH/8V2t7WW/UQATsEKbDK0ARFFHa7C5ZqLiqGBKOe2Xy
        dsXoZdxk5h19uqTVCmXhIiDDtYwvFUgL2fbl6TZfqLqB0qtRz//nLBbRgn10DK3wecKL2h
        13tojyAbQkBW0GjVgHjVvKi+hIf6XCg/QqXJQ2OOrsQVpYgvQDDUNhJRR8ahMkI/CjY09O
        kM+5yTaLbLYsyw5/sV3g8jH+24+mizrvCEPprHEOx9qZf2WcjB3Q9KqPEmeR2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620303246;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9P2kEhmr0i0YWJR71NrYPfolA7iSiSQtq+MyDZhViQ=;
        b=kIMs0rCkHtoKQu5ImlpKRk0UhAINa+PN8lz7PptEMZxgXcBBazJ+ThEBCfhMAKxNIZ9k4j
        IS825AIU+L4aT6Cw==
From:   "tip-bot2 for Wanpeng Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] context_tracking: Move guest exit context tracking
 to separate helpers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210505002735.1684165-2-seanjc@google.com>
References: <20210505002735.1684165-2-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <162030324563.29796.16229600493289889787.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     866a6dadbb027b2955a7ae00bab9705d382def12
Gitweb:        https://git.kernel.org/tip/866a6dadbb027b2955a7ae00bab9705d382def12
Author:        Wanpeng Li <wanpengli@tencent.com>
AuthorDate:    Tue, 04 May 2021 17:27:28 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 05 May 2021 22:54:10 +02:00

context_tracking: Move guest exit context tracking to separate helpers

Provide separate context tracking helpers for guest exit, the standalone
helpers will be called separately by KVM x86 in later patches to fix
tick-based accounting.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210505002735.1684165-2-seanjc@google.com

---
 include/linux/context_tracking.h |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index bceb064..b8c7313 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -131,10 +131,15 @@ static __always_inline void guest_enter_irqoff(void)
 	}
 }
 
-static __always_inline void guest_exit_irqoff(void)
+static __always_inline void context_tracking_guest_exit(void)
 {
 	if (context_tracking_enabled())
 		__context_tracking_exit(CONTEXT_GUEST);
+}
+
+static __always_inline void guest_exit_irqoff(void)
+{
+	context_tracking_guest_exit();
 
 	instrumentation_begin();
 	if (vtime_accounting_enabled_this_cpu())
@@ -159,6 +164,8 @@ static __always_inline void guest_enter_irqoff(void)
 	instrumentation_end();
 }
 
+static __always_inline void context_tracking_guest_exit(void) { }
+
 static __always_inline void guest_exit_irqoff(void)
 {
 	instrumentation_begin();
