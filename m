Return-Path: <linux-tip-commits+bounces-7934-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9820ED183AF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34DBD301D327
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2685B38FF08;
	Tue, 13 Jan 2026 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ACnRpPRK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NbX2ieYX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C40838F945;
	Tue, 13 Jan 2026 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301409; cv=none; b=ZSRkK43IqqKusNQivfPMdyAT/JK3DLHsyiI1PX3VT0i8YX8ILXmdTMjKKLL/gCKl1w/QPNX1iRNyxW5YgleUfTfKV2BK2zwpr4z55uTyq/yBPs09/GhEIScL/pDxRO1fGGbrXxFzK8pvFLeal+gTlfWTfXhYbxAn0dqviTsWDbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301409; c=relaxed/simple;
	bh=pGlsHD+dG+gSB2QJdu7XQP/HjOgUoC0j6hCWHHZbmQA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=paNHn6pMzAMAGmT6xPozZh4m1seGXXDb8th9nFpJIOVvibkkIRx4Gq7T5QXqF1tqQiYuYwSlO46q//nALp8uYa2f4vHYa7DFMSH9EXkd0lVsShie4nl8+C/xitqvE7SkcIlSExCtsKBFHPzrQ1yh67EJAXUQZIItedsWb3xbPUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ACnRpPRK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NbX2ieYX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:50:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCWiz/CiZhoTF6rvdkttiygnMd2hIt2ujh3LJXe/nns=;
	b=ACnRpPRKyWn7ub6BSMr9pGDj4LxECKInboxJYEKI8S7fefilH3Rzyglz7MSvC0FXicDbGz
	vVvkFn+oAf/DrCKOT30LR9vprzPvtZrVRuowHiCNG83+17LDHAu3HOGkpJ9dr10K1PGhid
	VmzfjXaSqASSGzoWq5HIUT7WHisshwyJu9ZUZ3XfvwvZ4ld+ntNsiMgQoowxKs9EyW7cN/
	1ETIboeqE4b38PfqqEtr+OHDaX7xfKUShmOkIxuZOA9rh5VlXCyuPswrX5G3boMENkrEIW
	6uKlFooAUZUUXMwXDnvTRAX2XDtxK/EkVgBaJoAgQkFxXElqC5LRo7MyB7AavQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCWiz/CiZhoTF6rvdkttiygnMd2hIt2ujh3LJXe/nns=;
	b=NbX2ieYXL6EL49uGO2HcQqoJZAI0M9NE8HK7ibakmqaB6IMPeJPFO2WAuF6H1r/Jx+x4/5
	3R8kVAfl5aCvVAAA==
From: "tip-bot2 for FUJITA Tomonori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] rust: helpers: Add i8/i16 atomic xchg_release helpers
Cc: Alice Ryhl <aliceryhl@google.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251223062140.938325-4-fujita.tomonori@gmail.com>
References: <20251223062140.938325-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830140437.510.1895144017250150114.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1bfca1e7e845a55fa82046727666f713d24ebdad
Gitweb:        https://git.kernel.org/tip/1bfca1e7e845a55fa82046727666f713d24=
ebdad
Author:        FUJITA Tomonori <fujita.tomonori@gmail.com>
AuthorDate:    Tue, 23 Dec 2025 15:21:39 +09:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:40 +08:00

rust: helpers: Add i8/i16 atomic xchg_release helpers

Add i8/i16 atomic xchg_release helpers that call xchg_release() macro
implementing atomic xchg_release using architecture-specific
instructions.

[boqun: Use xchg_release() instead of raw_xchg_release()]

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251223062140.938325-4-fujita.tomonori@gmail.=
com
---
 rust/helpers/atomic_ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index 177bb36..2b976a7 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -70,3 +70,13 @@ __rust_helper s16 rust_helper_atomic_i16_xchg_acquire(s16 =
*ptr, s16 new)
 {
 	return xchg_acquire(ptr, new);
 }
+
+__rust_helper s8 rust_helper_atomic_i8_xchg_release(s8 *ptr, s8 new)
+{
+	return xchg_release(ptr, new);
+}
+
+__rust_helper s16 rust_helper_atomic_i16_xchg_release(s16 *ptr, s16 new)
+{
+	return xchg_release(ptr, new);
+}

