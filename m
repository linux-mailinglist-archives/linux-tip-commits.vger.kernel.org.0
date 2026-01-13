Return-Path: <linux-tip-commits+bounces-7911-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11936D1833A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A6733049FE6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6618C36921B;
	Tue, 13 Jan 2026 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4J5XOulR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PVBFidKp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A7838A2A1;
	Tue, 13 Jan 2026 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301383; cv=none; b=Y9p+qoC39C2XUejzV3ZBKOsPsYiRzMMF8UlrEZ/E+6vNFq0fJIY8JcObr7IgNhPSlXpHntzzhbXG7hWvbfsvtFe3yfqBooa9aSK+KFl0uGIcU9X2DlkNa9j53RH8pzmWwfUaAE0wbtywEOPiQrcIZBOCG7FWfHiZ/PVtwA+Hbc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301383; c=relaxed/simple;
	bh=cCYukSBGdcELKpU/utXmnmd5cEM9sp7e9y86/6eLTyo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BDmigU2Woa7SrP0wHX5r2kh05FJoR31RNL1gAQ5IQcHh3uJsx61Si2oPX+jsyd51aEPMNgNxOIReWGS4Eof8GuUVQK0gAomjS7Wr9BDi46dmukye1QzY5ALkeydOKuas5naDI3fsyG8GxhYFfSFlPoIZbpbsT+cj2Mgi14APmlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4J5XOulR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PVBFidKp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301380;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxexmQELzn0sY1QDPatIaCBiZYkK+d2A1nRT0fLnm8k=;
	b=4J5XOulRxzbbeSHFHcFd3SFWdrwSO3HXY96cPLAKBvqxRx1cjRSnnjk3Z34ybgBgZ5QrHe
	LlmGYvq/L7ei42PLJaRdmrCytAZebEfefRoR3oRbKm2v7LqLZWKQDVNTo5vf5Rdip4uvCb
	ZnDsZRUvvR8ASsnS+rDTbmNn3x+BjWPLYcGfvirLFJg/PufNrXrV/1u80/SRG5AWMEGrPa
	OfQLemv8KjYtwSiN4Qx+9qMMGcy1dqoAFB0GNASHZEQu/axPv96vcaeHgcWgfJzxEDoz/X
	OgbkzaM/uxOEeb4Yh5sYe3Zhp0CjIeJxgC2inFaq1S7uUsvikHL/DAOGojPFxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301380;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxexmQELzn0sY1QDPatIaCBiZYkK+d2A1nRT0fLnm8k=;
	b=PVBFidKpIxB8flyGgB6omyWI4nRKGJ/CeMVTSdLEUlDDMkaP2dKZUKZYh3d1z4oHLWooVF
	Ve3U3ytV97H5YiCg==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: task: Add __rust_helper to helpers
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105-define-rust-helper-v2-21-51da5f454a67@google.com>
References: <20260105-define-rust-helper-v2-21-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830137897.510.12404160275575952745.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5f1193d55a4311780136044355b1f09e7b5abac7
Gitweb:        https://git.kernel.org/tip/5f1193d55a4311780136044355b1f09e7b5=
abac7
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Mon, 05 Jan 2026 12:42:34=20
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:42 +08:00

rust: task: Add __rust_helper to helpers

This is needed to inline these helpers into Rust code.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20260105-define-rust-helper-v2-21-51da5f454a67=
@google.com
---
 rust/helpers/signal.c |  2 +-
 rust/helpers/task.c   | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/rust/helpers/signal.c b/rust/helpers/signal.c
index 1a6bbe9..8511118 100644
--- a/rust/helpers/signal.c
+++ b/rust/helpers/signal.c
@@ -2,7 +2,7 @@
=20
 #include <linux/sched/signal.h>
=20
-int rust_helper_signal_pending(struct task_struct *t)
+__rust_helper int rust_helper_signal_pending(struct task_struct *t)
 {
 	return signal_pending(t);
 }
diff --git a/rust/helpers/task.c b/rust/helpers/task.c
index 2c85bbc..c0e1a06 100644
--- a/rust/helpers/task.c
+++ b/rust/helpers/task.c
@@ -3,60 +3,60 @@
 #include <linux/kernel.h>
 #include <linux/sched/task.h>
=20
-void rust_helper_might_resched(void)
+__rust_helper void rust_helper_might_resched(void)
 {
 	might_resched();
 }
=20
-struct task_struct *rust_helper_get_current(void)
+__rust_helper struct task_struct *rust_helper_get_current(void)
 {
 	return current;
 }
=20
-void rust_helper_get_task_struct(struct task_struct *t)
+__rust_helper void rust_helper_get_task_struct(struct task_struct *t)
 {
 	get_task_struct(t);
 }
=20
-void rust_helper_put_task_struct(struct task_struct *t)
+__rust_helper void rust_helper_put_task_struct(struct task_struct *t)
 {
 	put_task_struct(t);
 }
=20
-kuid_t rust_helper_task_uid(struct task_struct *task)
+__rust_helper kuid_t rust_helper_task_uid(struct task_struct *task)
 {
 	return task_uid(task);
 }
=20
-kuid_t rust_helper_task_euid(struct task_struct *task)
+__rust_helper kuid_t rust_helper_task_euid(struct task_struct *task)
 {
 	return task_euid(task);
 }
=20
 #ifndef CONFIG_USER_NS
-uid_t rust_helper_from_kuid(struct user_namespace *to, kuid_t uid)
+__rust_helper uid_t rust_helper_from_kuid(struct user_namespace *to, kuid_t =
uid)
 {
 	return from_kuid(to, uid);
 }
 #endif /* CONFIG_USER_NS */
=20
-bool rust_helper_uid_eq(kuid_t left, kuid_t right)
+__rust_helper bool rust_helper_uid_eq(kuid_t left, kuid_t right)
 {
 	return uid_eq(left, right);
 }
=20
-kuid_t rust_helper_current_euid(void)
+__rust_helper kuid_t rust_helper_current_euid(void)
 {
 	return current_euid();
 }
=20
-struct user_namespace *rust_helper_current_user_ns(void)
+__rust_helper struct user_namespace *rust_helper_current_user_ns(void)
 {
 	return current_user_ns();
 }
=20
-pid_t rust_helper_task_tgid_nr_ns(struct task_struct *tsk,
-				  struct pid_namespace *ns)
+__rust_helper pid_t rust_helper_task_tgid_nr_ns(struct task_struct *tsk,
+						struct pid_namespace *ns)
 {
 	return task_tgid_nr_ns(tsk, ns);
 }

