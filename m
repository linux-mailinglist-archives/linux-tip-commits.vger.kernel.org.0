Return-Path: <linux-tip-commits+bounces-7420-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 633DFC73AF7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 65D492AA1C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C5C33439B;
	Thu, 20 Nov 2025 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SfkZCcYN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="omzHHHd+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D743333434;
	Thu, 20 Nov 2025 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637608; cv=none; b=Rqt/q239XBGsV15U6nPY0KkvbIYZDc/bm1m+xVT3Ar2dCMsq6mFgGl9v/i+Br6KA6JFHPrtlmW2WMBaLaIDjho4fKGI3OUWsso0TzVMMXDgy4aUqVhOinEE8NM1G8p70+CjMcJAbHk4x+CGZgtl7VhGMkuOPl0/X704lgOxhe44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637608; c=relaxed/simple;
	bh=nG4PUwZao6Qg9XUi6NdDCw9khfITAPV1MAZT9iWLrzc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l0xBr8SJUjug7l3xtOLFXe4rQztMu6lKOTttnmMdAYEVhsIlzIZ6+28gVUzv0FCW0FKA2nTorED/UfQDu0s6w8E0SBUo6fAfZWG8ZJdEKc5DhJv0IofAmqysm/BS4F4LxeYmN0olO+7KicVySEz9hm2SE0j0m5npqCJkn7NfNeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SfkZCcYN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=omzHHHd+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:20:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXzNlosbzsgc0kKOMAoeSMPXd25o6RuQGXBdInSwD3g=;
	b=SfkZCcYNAHWauMwycVAvNKig95qWIEoVJjDwXE+WESiU6ZyLD1Bvrv/TvfNFClpkGiMsU2
	XLtf7Vj07DeXNwfO0U5f4hCneyayo9mLpEgJ6R3mpGM2Ud3IiOdxZ1ZovxnyIzVPpHsGyX
	lrMG443DGMHSlgz+1OKndlm1ZIpKD4zaQknfBLh+2jwGLLgE10HO0KcF0Cet3oU07l/da7
	208hJI7Nj9qrOOxmYTFq0eWHY+q6+Iii4aEax5EgvTHpuHsTq7r1fZ3I7y1B6F+zj5wBo9
	+YzKhYaO/gVp5XbTFQYYkg/ctIbeDeVjhxZYqB6enTFicVGyY91sOZBTotjKZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXzNlosbzsgc0kKOMAoeSMPXd25o6RuQGXBdInSwD3g=;
	b=omzHHHd+wKq/ofqIoYd+X/kZBOagYVHCsOOgmXcoFz41FbxrXz21ZwI3d8wpo1nGfjmKH5
	l+DJTuUDEpNRdBAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] cpumask: Introduce cpumask_weighted_or()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172549.448263340@linutronix.de>
References: <20251119172549.448263340@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176363760227.498.1772856884798481109.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     437cb3ded25038d5280d21de489ce78c745118d5
Gitweb:        https://git.kernel.org/tip/437cb3ded25038d5280d21de489ce78c745=
118d5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:26:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:54 +01:00

cpumask: Introduce cpumask_weighted_or()

CID management OR's two cpumasks and then calculates the weight on the
result. That's inefficient as that has to walk the same stuff twice. As
this is done with runqueue lock held, there is a real benefit of speeding
this up. Depending on the system this results in 10-20% less cycles spent
with runqueue lock held for a 4K cpumask.

Provide cpumask_weighted_or() and the corresponding bitmap functions which
return the weight of the OR result right away.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251119172549.448263340@linutronix.de
---
 include/linux/bitmap.h  | 15 +++++++++++++++
 include/linux/cpumask.h | 16 ++++++++++++++++
 lib/bitmap.c            |  6 ++++++
 3 files changed, 37 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 595217b..b0395e4 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -45,6 +45,7 @@ struct device;
  *  bitmap_copy(dst, src, nbits)                *dst =3D *src
  *  bitmap_and(dst, src1, src2, nbits)          *dst =3D *src1 & *src2
  *  bitmap_or(dst, src1, src2, nbits)           *dst =3D *src1 | *src2
+ *  bitmap_weighted_or(dst, src1, src2, nbits)	*dst =3D *src1 | *src2. Retur=
ns Hamming Weight of dst
  *  bitmap_xor(dst, src1, src2, nbits)          *dst =3D *src1 ^ *src2
  *  bitmap_andnot(dst, src1, src2, nbits)       *dst =3D *src1 & ~(*src2)
  *  bitmap_complement(dst, src, nbits)          *dst =3D ~(*src)
@@ -165,6 +166,8 @@ bool __bitmap_and(unsigned long *dst, const unsigned long=
 *bitmap1,
 		 const unsigned long *bitmap2, unsigned int nbits);
 void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int nbits);
+unsigned int __bitmap_weighted_or(unsigned long *dst, const unsigned long *b=
itmap1,
+				  const unsigned long *bitmap2, unsigned int nbits);
 void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
 		  const unsigned long *bitmap2, unsigned int nbits);
 bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
@@ -338,6 +341,18 @@ void bitmap_or(unsigned long *dst, const unsigned long *=
src1,
 }
=20
 static __always_inline
+unsigned int bitmap_weighted_or(unsigned long *dst, const unsigned long *src=
1,
+				const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits)) {
+		*dst =3D *src1 | *src2;
+		return hweight_long(*dst & BITMAP_LAST_WORD_MASK(nbits));
+	} else {
+		return __bitmap_weighted_or(dst, src1, src2, nbits);
+	}
+}
+
+static __always_inline
 void bitmap_xor(unsigned long *dst, const unsigned long *src1,
 		const unsigned long *src2, unsigned int nbits)
 {
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index ff8f41a..feba06e 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -729,6 +729,22 @@ void cpumask_or(struct cpumask *dstp, const struct cpuma=
sk *src1p,
 }
=20
 /**
+ * cpumask_weighted_or - *dstp =3D *src1p | *src2p and return the weight of =
the result
+ * @dstp: the cpumask result
+ * @src1p: the first input
+ * @src2p: the second input
+ *
+ * Return: The number of bits set in the resulting cpumask @dstp
+ */
+static __always_inline
+unsigned int cpumask_weighted_or(struct cpumask *dstp, const struct cpumask =
*src1p,
+				 const struct cpumask *src2p)
+{
+	return bitmap_weighted_or(cpumask_bits(dstp), cpumask_bits(src1p),
+				  cpumask_bits(src2p), small_cpumask_bits);
+}
+
+/**
  * cpumask_xor - *dstp =3D *src1p ^ *src2p
  * @dstp: the cpumask result
  * @src1p: the first input
diff --git a/lib/bitmap.c b/lib/bitmap.c
index b976928..9dc5265 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -355,6 +355,12 @@ unsigned int __bitmap_weight_andnot(const unsigned long =
*bitmap1,
 }
 EXPORT_SYMBOL(__bitmap_weight_andnot);
=20
+unsigned int __bitmap_weighted_or(unsigned long *dst, const unsigned long *b=
itmap1,
+				  const unsigned long *bitmap2, unsigned int bits)
+{
+	return BITMAP_WEIGHT(({dst[idx] =3D bitmap1[idx] | bitmap2[idx]; dst[idx]; =
}), bits);
+}
+
 void __bitmap_set(unsigned long *map, unsigned int start, int len)
 {
 	unsigned long *p =3D map + BIT_WORD(start);

