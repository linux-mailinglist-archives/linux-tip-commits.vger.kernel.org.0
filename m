Return-Path: <linux-tip-commits+bounces-7915-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FE3D1835E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DE12306594C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5672C3815F2;
	Tue, 13 Jan 2026 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W+PaybGm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8B6UqFcW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C418E38B9A7;
	Tue, 13 Jan 2026 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301387; cv=none; b=JV6UsciJJco5cHaHT4/TmGxesTc6jvG60om+efNs9Zc17iZbYp7TYVRv/PTzhWfGNDpLPz9+Nh+u8Vp3y8PkGV2Wq2FfFUtNIccrWJeVcokXfsjA4lDX82Y0o5oG9LebqPrvp1MzkyU8Yj4tEUX2AdLYLXtyWAnNnKrmc/G5pS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301387; c=relaxed/simple;
	bh=qa/xDK03UB1fK1QCOZUOafHYaTXHdaEmZDC3NfA2c0E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WdJrXmzpil5eTzV767GPH5c6aXx1f/ZBv2nnlc8RvIYaf9z5HVYoh9YMf1o9546OYTRl32rB3KYWS55yufHASOn119YdEQgly5nU5dGO+hR++Li0nGGBm9gppiWVybK5j5kRqpTsjElbm4GBun8lGEMpiGU6QS3QrLiTcxYVySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W+PaybGm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8B6UqFcW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301384;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhendKU5ga3fAPtFVYQJiz89u7Lz5J3pBlciQ56BdVU=;
	b=W+PaybGmGi/Ia8V54PnCKjsogu0MPVJ5+r6AMFUUFGmwyKYVglqxrnoHWMV964297xvdI/
	gTPf3TGyjuWLYj1XsRU5SzHqEiCPpCAs+wAoiP14nhBiiP2ySgQIoQRNZf5tMn8gpbB9Tq
	/ym4Hhwudag5ZHxb4Esh3KW2qJUFPf1ybUplDiZ+qc40UEozH3iNAjX5wlBaAqkaYZM5jU
	DgramPbM28znN5CfLQ1embGyuiFaG6+8hi7AKTjyqHmnbWtU0Y3UQ6YiEqlV59WomPuwrl
	+y81LE4dCHTU6rfwA6Fr0sFsTlmwIXEJIvClksTLvYpPGnv9VzQpk3fUqEub2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301384;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhendKU5ga3fAPtFVYQJiz89u7Lz5J3pBlciQ56BdVU=;
	b=8B6UqFcWGOe5qYQXv9ElySFyVWpuz0gsbDKKeW02Bwhp5SgVn3ZKGsHxYKbx46+p1cXZpi
	aVN7xZBoyF4mI2CQ==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: processor: Add __rust_helper to helpers
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105-define-rust-helper-v2-13-51da5f454a67@google.com>
References: <20260105-define-rust-helper-v2-13-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830138321.510.13221888469624853968.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a87e6fe8738fabf9881758b79b0db592c057acbd
Gitweb:        https://git.kernel.org/tip/a87e6fe8738fabf9881758b79b0db592c05=
7acbd
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Mon, 05 Jan 2026 12:42:26=20
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

rust: processor: Add __rust_helper to helpers

This is needed to inline these helpers into Rust code.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20260105-define-rust-helper-v2-13-51da5f454a67=
@google.com
---
 rust/helpers/processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/helpers/processor.c b/rust/helpers/processor.c
index d41355e..76fadbb 100644
--- a/rust/helpers/processor.c
+++ b/rust/helpers/processor.c
@@ -2,7 +2,7 @@
=20
 #include <linux/processor.h>
=20
-void rust_helper_cpu_relax(void)
+__rust_helper void rust_helper_cpu_relax(void)
 {
 	cpu_relax();
 }

