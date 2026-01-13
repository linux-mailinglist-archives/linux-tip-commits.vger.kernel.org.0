Return-Path: <linux-tip-commits+bounces-7942-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C32D0D18436
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 537BF3022381
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21454392B6C;
	Tue, 13 Jan 2026 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s5pOtiR4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E0InCZvE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C2B3921E1;
	Tue, 13 Jan 2026 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301421; cv=none; b=tN6UbztaRCR/xj5ygmw5ym1XAC3khhqXAUaoGY+NkIllGK9Z7nUpc531/VJGCT8PmpJLnlDAHNlPhsmUVGDgmMTCu75e7RvA+0YeTYVKJDLRYPHlkuj9RzSuSbSwlKo3nsP4VfVY6CxeHvwZ84SxHRBCOgdIZ8zpoqdbIUxHBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301421; c=relaxed/simple;
	bh=7CY+D3wDSkMlKDVCD2XMUlV47Akk5sXQhutv8qRT4jI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gl1kuNw9eYBTaHkvNY/dIYVfro8vOGe0OilENTutGnFAJzINbsalxBOVnpNd+7mYvc2MDXPPp9EbxMF1vv2PKqQYB9EkPsyAY+NeAZ40ci75Cz2lkygJgmmURuDDj8JN+9qbCC4JYVR0mN0jGPdJNs+t3u1K+vfT1vbzFNLh8n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s5pOtiR4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E0InCZvE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:50:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301411;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pkq4GP4+/fZdUBHfRf/ErsfVmVqhTGf/EzG3zOX3IwM=;
	b=s5pOtiR4gDRKvSsx5FxfH9f6mmcC2o5kC1jcxQDtbAr1x1q6v4zwEYpSg9p2bF4XP/3wXV
	+ZvtHuT6y7EqYjr/ymrim5LeFaX9WTXMLzkXvWN6LEnnsBsBA+6ruyJjbzJTkhMejVSAB1
	FH2FVlZoaco9VENSPuepQyG2F5DNt1TSk9oH1yHfcct8x22BdI6mjSePuKY1lUUxEO2AjN
	1RwPKrEzFKT0Knk7yjp3O9sfApZR36UdrgLaRYM/K+R0fgLFUr1wqA0mVperMusRaDLJWH
	3VrmfELKXeFqHtPlmk8aXFBQ6rWizuPXoHcwNeRYfDCusCTc5hY3l8b6pwcl2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301411;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pkq4GP4+/fZdUBHfRf/ErsfVmVqhTGf/EzG3zOX3IwM=;
	b=E0InCZvESFlAM5Vs3UKuZy2e20TTrE+vfnyy1ZRiGPwM29R92CXjsZObGLDgwnD7OISI/y
	QAZFJ2h29t3aC8BQ==
From: "tip-bot2 for Alice Ryhl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: sync: Implement Unpin for ARef
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251218-unpin-for-aref-v2-1-30d77129cbc6@google.com>
References: <20251218-unpin-for-aref-v2-1-30d77129cbc6@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830140979.510.16076936510207289691.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     09248ed8cdb6345afc883c02aecd79dfbd9c2a9c
Gitweb:        https://git.kernel.org/tip/09248ed8cdb6345afc883c02aecd79dfbd9=
c2a9c
Author:        Alice Ryhl <aliceryhl@google.com>
AuthorDate:    Thu, 18 Dec 2025 08:25:13=20
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:40 +08:00

rust: sync: Implement Unpin for ARef

The default implementation of Unpin for ARef<T> is conditional on T
being Unpin due to its PhantomData<T> field. However, this is overly
strict as pointers to T are legal to move even if T itself cannot move.

Since commit 66f1ea83d9f8 ("rust: lock: Add a Pin<&mut T> accessor")
this causes build failures when combined with a Mutex that contains an
field ARef<T>, because almost any type that ARef is used with is !Unpin.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20251218-unpin-for-aref-v2-1-30d77129cbc6@goog=
le.com
---
 rust/kernel/sync/aref.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index 0d24a04..0616c03 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -83,6 +83,9 @@ unsafe impl<T: AlwaysRefCounted + Sync + Send> Send for ARe=
f<T> {}
 // example, when the reference count reaches zero and `T` is dropped.
 unsafe impl<T: AlwaysRefCounted + Sync + Send> Sync for ARef<T> {}
=20
+// Even if `T` is pinned, pointers to `T` can still move.
+impl<T: AlwaysRefCounted> Unpin for ARef<T> {}
+
 impl<T: AlwaysRefCounted> ARef<T> {
     /// Creates a new instance of [`ARef`].
     ///

