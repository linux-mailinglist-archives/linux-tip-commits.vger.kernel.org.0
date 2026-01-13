Return-Path: <linux-tip-commits+bounces-7914-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E7CD18352
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E3C33039871
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEC538B9B6;
	Tue, 13 Jan 2026 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JijA/+2c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qT0FJzEf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEA538B7B7;
	Tue, 13 Jan 2026 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301386; cv=none; b=HLM6DzFhc3z4GOi+s3OPoyQ7TPgWTu/LK0DnC0zg8+eJq1AzRvS+C+zikI3zcNNAHh7iH3UpmPz2FkKJfNvagdvQdlcChwuUWUMLSDEDdAhbRESx9/VpxfTrlzqbijM1QjlQykZ+oGYJuIwLKM2dblUSDp4Y6vH4w+oBKOgMw+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301386; c=relaxed/simple;
	bh=zL0VdgWG394H4tqMidKZ/fP43uVQTW3LDNRjciYz0eg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FVW5ZUT8S63OMG4PuPouCnAuEvR8w6jmyCsFIartwdM2DIlQeBanbV2DtbXMJ9oOKxHkGbRZuH9j9mK92RJf/Zu0kyTCYl3QQeFJgI54wyHXAj2gGn8y2ZaoQwJMhWA9pKiFiomg8xthIiRrwgX4wdMzVFOEJ1U0tmyxcPIYMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JijA/+2c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qT0FJzEf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301383;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3INeJVOD7DHVx1DaNt4h95jrMbli5pbRU0n6VK6VeWU=;
	b=JijA/+2cpZX537EnpvO0NEV2PuICke1KriXtWblw/nLD+vv9AwMy/6mNI0R03omyYkzPEL
	pXcKDHlMnpkmv6Ighuphm/5hl/zRQQIe6VsvN2trGUw4wcS2U1IkK1Ypd4osCbNANYsgyj
	8+O2YS71KjVMRdw6yxpSWS0RdZcnsvkgdWnzp8ZIBptuK5XFktMEIo9JjngDZ4p/M1C+yk
	Lne+oYtI7X2OO9ynN44aUBFT3bcYJEC0RgMbanWCyW4xER1VcJYvGf/6hMi07uWOIWbBqq
	Sh+gEfHhTiFlEyPaKoCqAIwzS1aq+B9qEKuwFBpeBGwuTS9Fvul0sGccuZBEcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301383;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3INeJVOD7DHVx1DaNt4h95jrMbli5pbRU0n6VK6VeWU=;
	b=qT0FJzEf1eX4lvGhf1e4zMTT2sHGiKAgUU0DbfQMexy9EMt0KvY6QWleDFZOLLI/u/BD53
	YIrM541jOQaTr7Aw==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: rcu: Add __rust_helper to helpers
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>,
 "Joel Fernandes (NVIDIA)" <joel@joelfernandes.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105-define-rust-helper-v2-16-51da5f454a67@google.com>
References: <20260105-define-rust-helper-v2-16-51da5f454a67@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830138216.510.9212112343351002380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5e03edaed373f41e7a3c8617e01891eb680d62aa
Gitweb:        https://git.kernel.org/tip/5e03edaed373f41e7a3c8617e01891eb680=
d62aa
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Mon, 05 Jan 2026 12:42:29=20
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:42 +08:00

rust: rcu: Add __rust_helper to helpers

This is needed to inline these helpers into Rust code.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Joel Fernandes (NVIDIA) <joel@joelfernandes.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20260105-define-rust-helper-v2-16-51da5f454a67=
@google.com
---
 rust/helpers/rcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/helpers/rcu.c b/rust/helpers/rcu.c
index f1cec65..481274c 100644
--- a/rust/helpers/rcu.c
+++ b/rust/helpers/rcu.c
@@ -2,12 +2,12 @@
=20
 #include <linux/rcupdate.h>
=20
-void rust_helper_rcu_read_lock(void)
+__rust_helper void rust_helper_rcu_read_lock(void)
 {
 	rcu_read_lock();
 }
=20
-void rust_helper_rcu_read_unlock(void)
+__rust_helper void rust_helper_rcu_read_unlock(void)
 {
 	rcu_read_unlock();
 }

