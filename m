Return-Path: <linux-tip-commits+bounces-6981-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BCCBFC231
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Oct 2025 15:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830AB1887427
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Oct 2025 13:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684882F616A;
	Wed, 22 Oct 2025 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wx/3AhbT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ATQpbpH1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC37288502;
	Wed, 22 Oct 2025 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139725; cv=none; b=VvHgPVKABwfp61hhT9BNwhVqaIF34nh4++eK4Mu9gHrfOvBmHSETW1fgib9KZK1lsfsfdcDEy0FL4Tm8XdGw0Om7Scsr9qFtNRv1wauIHIOcqa9dKXYgrnb96ilyKlNP9q5nWr/6zhRygScTC4uiSGghf1hyWMIe36fBsm8Eej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139725; c=relaxed/simple;
	bh=QKksJPOg3Ld65y+A9A7qYmdsNu/AEBhnB776/7uWjaQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Bf423NrwOjOpPwV94J6AjqrP1v8b8vO9BqR3mlNwFt4+zkcaaVjmpLD9Z0ngvTMzUfadcNji8HDsqGhVpnapKyZLSSDs9X3GkOqWfBhlD8saVJ9FOFhlTmZidbMoxYndy+doz7nSct8y/Kko8E7E0P48MwYBBIL+H55YzPtPU2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wx/3AhbT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ATQpbpH1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 22 Oct 2025 13:28:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761139721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJ+EdhrldHNMGhJUcDvaVq4BjCLMdnGx8kloR7YyxaI=;
	b=Wx/3AhbTunPyMThgCX4drIzym6+z9V0rtLlnQKuAn3U81tlS+E+RdzRHMwWQj7TU7VvNo9
	PfFCn3moeN1hu+8Anm2audZ4uzISbn0DGlaU5F0FqbGRPkyU+gh8kOutjh22wuQlYMTsYN
	N8BAZ3PycFAeWJ/84s5ukL0RX0bgDD7W8WZKNhW/t8pzlO6PmLxpJg5lyUNbGHB3HqVnkx
	z7kyj5oG+/5DcWCWZPt3uv2Xflvh1LoffGKfWj7zyYga75rvzgv3Ri7pHrjQRw/ynqM6Ql
	OGUjU8AWNGidEP2f2gIGysc6xB28V315YsxTmtADHuvU6sbghV+peLRICiQtwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761139721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJ+EdhrldHNMGhJUcDvaVq4BjCLMdnGx8kloR7YyxaI=;
	b=ATQpbpH1OuQUH9vfN9uX4WLtXH4n38HEku0YktrJOwm/rDIQ/EwAtPbvFITUVeBvo4GdOu
	ajdU8FceliKG1vCw==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: debugfs: Implement Reader for Mutex<T> only
 when T is Unpin
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Danilo Krummrich <dakr@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251022034237.70431-1-boqun.feng@gmail.com>
References: <20251022034237.70431-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176113972009.2601451.278359003080954159.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     37d0472c8ac441af8bc10fc4959ad9d62dd5fa4c
Gitweb:        https://git.kernel.org/tip/37d0472c8ac441af8bc10fc4959ad9d62dd=
5fa4c
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Tue, 21 Oct 2025 23:42:37 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Oct 2025 15:21:51 +02:00

rust: debugfs: Implement Reader for Mutex<T> only when T is Unpin

Since we are going to make `Mutex<T>` structurally pin the data (i.e.
`T`), therefore `.lock()` function only returns a `Guard` that can
dereference a mutable reference to `T` if only `T` is `Unpin`, therefore
restrict the impl `Reader` block of `Mutex<T>` to that.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Link: https://patch.msgid.link/20251022034237.70431-1-boqun.feng@gmail.com
---
 rust/kernel/debugfs/traits.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.rs
index ab009eb..ba7ec5a 100644
--- a/rust/kernel/debugfs/traits.rs
+++ b/rust/kernel/debugfs/traits.rs
@@ -50,7 +50,7 @@ pub trait Reader {
     fn read_from_slice(&self, reader: &mut UserSliceReader) -> Result;
 }
=20
-impl<T: FromStr> Reader for Mutex<T> {
+impl<T: FromStr + Unpin> Reader for Mutex<T> {
     fn read_from_slice(&self, reader: &mut UserSliceReader) -> Result {
         let mut buf =3D [0u8; 128];
         if reader.len() > buf.len() {

