Return-Path: <linux-tip-commits+bounces-6574-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9634B56017
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 12:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CD8585D81
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DA82E8E0B;
	Sat, 13 Sep 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3qnF/fYC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kUFPQgsS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC332BE05F;
	Sat, 13 Sep 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758532; cv=none; b=a/nnOhS07bzowRBfUU9PqbUZq8pNpSoPSC7N04OVI2Nrb8rnlRuJxE2u+9kH0nML/gSoBZMajCkn1whO+YxwKiuqWNmv0j3vvdQ/DgtAfaUdZEd82DP/Ds5dIuI/LtUpOEgVh/wKe9i0tLtHDBzOSLJRaD2w1qs4s8I2xPKnYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758532; c=relaxed/simple;
	bh=cNk2OGYhIWTAwpccp9hYEZug0LP6QyAtA8hc5xcwzKA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NX+XE9L+FCyuPnShVyum9AlXSAwM/KnWbPQjBl+uZrAusXMTcqnYzCjNOcYzTYbDa3cTaHp18YpnDQggxjwSc7F0FSs5VI3w4QrJpl5XUcvRp7chPwZ1tarx7igJEe3ox28H990jVP/tnSNchYhRcAtK5w7EGAAvk8WjZyOxuKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3qnF/fYC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kUFPQgsS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Sep 2025 10:15:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757758528;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXK8JAc49/SeOX248Wa3aaM8+ihxjuJUZQZyITgeZ1w=;
	b=3qnF/fYCWB49rnGJGpIeub/J5wOGC3qeWEnzDDAY2tL6PGZv+FwibmpJPO4WgX7CnUZvvI
	Jbrqp8LLt+i6pCGNrOLYk6Q+Kdhq2UIsGxiHm5e+zgeJ0n4C5ltSQnCVN/+xJiOK4LE/Eq
	rJkhew5s+qjfrXfhuWQJiPI1t3TZsVv2h6yXt3iDieDxPyTlRTSlSYsHYOCLXWDBysgPF7
	aXiNhuJBdh3+ETyIRvjif8UKuHGH+rL5K42DF0Sz2PmuOxxsLGqylEDWHcjrwQMZIMIqCH
	A14VZJhnTFaIGUqN3YL8qD7W0Fe/tgXlotmH0yCdukwRP3t7Ixn8aJsoIxH+PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757758528;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXK8JAc49/SeOX248Wa3aaM8+ihxjuJUZQZyITgeZ1w=;
	b=kUFPQgsSrS6XJ9bcyuYwF9s2wfgEsup+jho0NbSkwXs4NfDWx/Zn63F+4Xqoa1ZCii8KcD
	WiUIq6zfTmr2qnAg==
From: "tip-bot2 for Gary Guo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] MAINTAINERS: update atomic infrastructure entry
 to include Rust
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250905044141.77868-15-boqun.feng@gmail.com>
References: <20250905044141.77868-15-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175775852668.709179.9187299749961230265.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     502ae97746ab6d7b7b48d54b6a85a11815f390d0
Gitweb:        https://git.kernel.org/tip/502ae97746ab6d7b7b48d54b6a85a11815f=
390d0
Author:        Gary Guo <gary@garyguo.net>
AuthorDate:    Thu, 04 Sep 2025 21:41:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 13 Sep 2025 12:07:59 +02:00

MAINTAINERS: update atomic infrastructure entry to include Rust

I would like to help review atomic related patches, especially Rust
related ones, hence add myself as an reviewer.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250723233312.3304339-6-gary@kernel.org
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 538778b..2f346ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3992,6 +3992,7 @@ M:	Will Deacon <will@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Boqun Feng <boqun.feng@gmail.com>
 R:	Mark Rutland <mark.rutland@arm.com>
+R:	Gary Guo <gary@garyguo.net>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/atomic_*.txt
@@ -4001,6 +4002,7 @@ F:	include/linux/refcount.h
 F:	scripts/atomic/
 F:	rust/kernel/sync/atomic.rs
 F:	rust/kernel/sync/atomic/
+F:	rust/kernel/sync/refcount.rs
=20
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
 M:	Bradley Grove <linuxdrivers@attotech.com>

