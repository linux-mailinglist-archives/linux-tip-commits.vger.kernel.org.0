Return-Path: <linux-tip-commits+bounces-5978-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F9AAF6D10
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 10:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A3407AB6B4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 08:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501272D193F;
	Thu,  3 Jul 2025 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MnfcQDy/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hGqPwB1N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B72D12F4;
	Thu,  3 Jul 2025 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531773; cv=none; b=QOB2GkBF16KuJq4SPXshBSYuCr4inrgKukNQv9lJlBZWUZOtkqCPJ4LTNIKWqiugRBb0V8rbMytc2Rm11ZT7FsPiiJDeRgFBnlXw5xpjI7JKIKwImiMbEd9es8EJzANw35HszQxjuxW8CfnXme03aIAq+8JwqO6PubvRNfDsKgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531773; c=relaxed/simple;
	bh=PocUKVU8bpaTL79PtGtVrO/VdPXkVJhzZIN8jY8Nvik=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VqX8IoEzSex362w/10FrYkSqVwzQKgBV37fmTxC9IiasyCMWCThv7bjnqupH0CPoe4jXbZ/Yp8cS7ej1I4hUF5arzEs2wbHOt/pIK86PPkRH3ot+MzCo30sx5Ie2ngFuWPT8IPHLCBwD6tlXU8i3MFL+epoc9OEBKXI33MQaOHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MnfcQDy/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hGqPwB1N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 08:36:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751531768;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KdXCfmPMNArqLx3RS6TzQykLEO6ZfX9xe/GMYyUxm9o=;
	b=MnfcQDy/EGrWtimaV8GvgQS94MYIBxtkUd2p6h3mi7jluRlZdqmxl+sm15XCWJCpZOrtcv
	6bNnLpNox1Z7h/a0kHNP6leMIZzp1mKvwyBTGIJF9Z0GNxyso8vVHzBUsUVwSLE6ZGd0Q0
	R+ZMNwszbbGl5r4i2pvOWvzjz7Il6lVVWk4vIygPnO9CgoLo5XvRgx7vItXJ75Y5S3i5rB
	yQVJZcI0UilQI9vu161eGb9b7QSeWf4fk76gNo7WF2S1EBLMo5PDu3Qz+Dmvjw51ADGZmd
	XsAfTaoPlLcqS++Yfqe+GvUZCTKIf48pMW26o3mUUAnzK0iyB5qim8QMdWRing==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751531768;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KdXCfmPMNArqLx3RS6TzQykLEO6ZfX9xe/GMYyUxm9o=;
	b=hGqPwB1N5Oj/4CKznqq2DclcR8OmkiO1GB1GI/gwSc4Uvic+U7ebf90lX0x6zuonAaRPfP
	Wr9MJuE0dQrTWMDQ==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rust: task: Add Rust version of might_sleep()
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250619151007.61767-3-boqun.feng@gmail.com>
References: <20250619151007.61767-3-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175153176741.406.14557081807475800171.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7e611710acf966df1e14bcf4e067385e38e549a1
Gitweb:        https://git.kernel.org/tip/7e611710acf966df1e14bcf4e067385e38e549a1
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Fri, 11 Apr 2025 07:56:23 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Tue, 24 Jun 2025 15:53:50 -07:00

rust: task: Add Rust version of might_sleep()

Add a helper function equivalent to the C's might_sleep(), which
serves as a debugging aid and a potential scheduling point.

Note that this function can only be used in a nonatomic context.

This will be used by Rust version of read_poll_timeout().

[boqun: Use file_from_location() to get a C string instead of changing
__might_sleep()]

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250619151007.61767-3-boqun.feng@gmail.com
---
 rust/helpers/task.c |  6 ++++++
 rust/kernel/task.rs | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/rust/helpers/task.c b/rust/helpers/task.c
index 31c33ea..2c85bbc 100644
--- a/rust/helpers/task.c
+++ b/rust/helpers/task.c
@@ -1,7 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/kernel.h>
 #include <linux/sched/task.h>
 
+void rust_helper_might_resched(void)
+{
+	might_resched();
+}
+
 struct task_struct *rust_helper_get_current(void)
 {
 	return current;
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 8343683..7d0935b 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -400,3 +400,27 @@ impl PartialEq for Kuid {
 }
 
 impl Eq for Kuid {}
+
+/// Annotation for functions that can sleep.
+///
+/// Equivalent to the C side [`might_sleep()`], this function serves as
+/// a debugging aid and a potential scheduling point.
+///
+/// This function can only be used in a nonatomic context.
+///
+/// [`might_sleep()`]: https://docs.kernel.org/driver-api/basics.html#c.might_sleep
+#[track_caller]
+#[inline]
+pub fn might_sleep() {
+    #[cfg(CONFIG_DEBUG_ATOMIC_SLEEP)]
+    {
+        let loc = core::panic::Location::caller();
+        let file = kernel::file_from_location(loc);
+
+        // SAFETY: `file.as_ptr()` is valid for reading and guaranteed to be nul-terminated.
+        unsafe { crate::bindings::__might_sleep(file.as_ptr().cast(), loc.line() as i32) }
+    }
+
+    // SAFETY: Always safe to call.
+    unsafe { crate::bindings::might_resched() }
+}

