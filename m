Return-Path: <linux-tip-commits+bounces-7922-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 977ACD183BB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FD4030928AF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5450E38B7AF;
	Tue, 13 Jan 2026 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ehoNsZkN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MG/Un6OM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195633876C4;
	Tue, 13 Jan 2026 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301402; cv=none; b=DTu6hWhmbtDP90YBmMpVjVkUl9dqE/ncCx9+nb3gGKdGjIqbf74YXYa7e566633MRFuFt6rlxbDfX0QbsUzegTj0g1O+Y8S+WxIVLHcsBy+Eqt4DpdqcUZrZUlU295v81nnkujDX1DwwoY9CWJAKpUon402RyMKNnzvCt1HZYB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301402; c=relaxed/simple;
	bh=cCIyGE1MrGItiLe4mb0zDZjJL16v2yB7dOyzuLEybSk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HsLwdGv7OGtnMII6pBefAK4S6NgNaHeCs78XQxEoltsTd5YTd1rje1XlkomJLdi/CKfsRgx7LaWzActfBUt2FY+Axqp6uPTH0UXxfpNqIhLMgNxoKTnGMsLQEzJu9p2iFApxkeqW81B+fdmY1/HbHOytJws2abxNBVrsPYKr6mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ehoNsZkN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MG/Un6OM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=695uxH4wubPFRnd3kGT5DcALuSowrjS+6Ism/K7RVMg=;
	b=ehoNsZkNK8o7q2hq3MR9z0o3+Z3XySWCsZZUMldxE2ss8LEz3StG4imsR4mTJZW3d5P+rF
	FnHbrxrhy/8oAZNQxF/xhVT0w/hsqkqMRjaXDhMdyzzHLG7es5KFE1S9qMkdERz0UXYahY
	paL/M5apExJ2PoEMcQtucZb++hnmQaOmxq5Oear4TK78THGyJx2QUTRgGit7SoNSp67vuu
	HOtNCg54APeEu3wIEIXBT+5QG/5V5UcUvTkC3xPeTV99sqar4tKpWY9ZOPO5mOD05cXz9Y
	hNkBnsTJRJa7gyHqgCJiL3OixzYqI+w8paqiVhPkWEEMQ8YoPVRI+rO8NUO+Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=695uxH4wubPFRnd3kGT5DcALuSowrjS+6Ism/K7RVMg=;
	b=MG/Un6OMgJ3S7LVVEyNHnPiA63UdXwpVi90u2JfIu3y4cCunW5Ig+vzZx+oI+Rd2eJ2lma
	iO6dIkz2VfSNHsDg==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: barrier: Add __rust_helper to helpers
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105-define-rust-helper-v2-1-51da5f454a67@google.com>
References: <20260105-define-rust-helper-v2-1-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830138754.510.5537471581432388820.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     aa574e0f21a6e7a28e4b8794ad4238d3bfd4f9df
Gitweb:        https://git.kernel.org/tip/aa574e0f21a6e7a28e4b8794ad4238d3bfd=
4f9df
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Mon, 05 Jan 2026 12:42:14=20
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

rust: barrier: Add __rust_helper to helpers

This is needed to inline these helpers into Rust code.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20260105-define-rust-helper-v2-1-51da5f454a67@=
google.com
---
 rust/helpers/barrier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/helpers/barrier.c b/rust/helpers/barrier.c
index cdf28ce..fed8853 100644
--- a/rust/helpers/barrier.c
+++ b/rust/helpers/barrier.c
@@ -2,17 +2,17 @@
=20
 #include <asm/barrier.h>
=20
-void rust_helper_smp_mb(void)
+__rust_helper void rust_helper_smp_mb(void)
 {
 	smp_mb();
 }
=20
-void rust_helper_smp_wmb(void)
+__rust_helper void rust_helper_smp_wmb(void)
 {
 	smp_wmb();
 }
=20
-void rust_helper_smp_rmb(void)
+__rust_helper void rust_helper_smp_rmb(void)
 {
 	smp_rmb();
 }

