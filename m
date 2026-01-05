Return-Path: <linux-tip-commits+bounces-7822-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89355CF5458
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 19:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1594300E7AC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 18:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9953333EAEC;
	Mon,  5 Jan 2026 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eTotU5DI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R0LioIuB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC563C38;
	Mon,  5 Jan 2026 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767639086; cv=none; b=VJd8IMZtXYb6/VUlE6kFtb7mNs6VQdVpmulXJXJcVGRKHIDX7LOyfvKNwsKjvOnk3I4+mqbyAB65iil1BcKuKHda3jN2zJOt9r85lvYSNoLY1CkherolCygukRlnrW7o3GWP6T0KLDcIqdEVy7StmHhObRzSV+n8iiIUdgcRp/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767639086; c=relaxed/simple;
	bh=7676Tb+JAfWlGXXq/xLMl7x37AnTmN533W/V6Npa1LE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eq5bIs9c608FKW8rlJzSWc2sqmzEK9uUppbv8Dyf8Pc9qhYqEEMYk/OClScVG13TuSDyVCbzAXUi9OvsMDRX19zHwP4lr3mXG5UIIpTp/GhXAVj1I+ojCF9UEjX5HAQtN6stwqtZYIJ3C/XEafKrZPHRIbK3zsctqdU8b68pasY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eTotU5DI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R0LioIuB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 18:51:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767639082;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MoTQeT4ROWjmoNCyTcwWtS9egYbDxir5jeZUmliCBY=;
	b=eTotU5DIRvpKWA4rCeqtOA9xX1p0LaCHyVy1HPiTCrgtHZJ8sYxCte+Otdz2vt2a+a82n/
	jzUJ+3EAQwod8at48SUhDDsiOIoUClQLIKjFY/ZxDidaeM4fyThzX7jM2Imo3GcNIco9Jm
	cEx4IzJPb0ZKdhZ57lT/FOQhUF6O8EeyYifWc2wJygVsv2TYwRix+CiGXWAXjfS0OWfE54
	w2205Wog3F3cAd1/5i+64fl9o0LdX73P8K64rX1MIoeXA/7AIQQOB2PFm81EMRpKT9wmYL
	ue/a1ZxV0YuVNm0NpeJ2If9fb0U18vU8w5u0Ne0ASgdf73lpftgVBTCFOvI9bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767639082;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MoTQeT4ROWjmoNCyTcwWtS9egYbDxir5jeZUmliCBY=;
	b=R0LioIuBuyKEuW8e7iRace2GS9QJpiw2In5unKgCZxmu1TJMlxSsS0OGubERcdwEle44Bd
	0Vl5DSkbOVJ1Y4Dg==
From: "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/lib: Inline csum_ipv6_magic()
Cc: Eric Dumazet <edumazet@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251113154545.594580-1-edumazet@google.com>
References: <20251113154545.594580-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176763908096.510.3138878419623948783.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     529676cabcf4a5046d217bba2c8f3b94a3f6a10f
Gitweb:        https://git.kernel.org/tip/529676cabcf4a5046d217bba2c8f3b94a3f=
6a10f
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Thu, 13 Nov 2025 15:45:45=20
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 05 Jan 2026 10:14:05 -08:00

x86/lib: Inline csum_ipv6_magic()

Inline this small helper. It has been observed to consume up
to 0.75%, which is significant for such a small function.

This should reduce register pressure, as saddr and daddr are often
back to back in memory.

For instance code inlined in tcp6_gro_receive() will look like:

 55a:	48 03 73 28          	add    0x28(%rbx),%rsi
 55e:	8b 43 70             	mov    0x70(%rbx),%eax
 561:	29 f8                	sub    %edi,%eax
 563:	0f c8                	bswap  %eax
 565:	89 c0                	mov    %eax,%eax
 567:	48 05 00 06 00 00    	add    $0x600,%rax
 56d:	48 03 46 08          	add    0x8(%rsi),%rax
 571:	48 13 46 10          	adc    0x10(%rsi),%rax
 575:	48 13 46 18          	adc    0x18(%rsi),%rax
 579:	48 13 46 20          	adc    0x20(%rsi),%rax
 57d:	48 83 d0 00          	adc    $0x0,%rax
 581:	48 89 c6             	mov    %rax,%rsi
 584:	48 c1 ee 20          	shr    $0x20,%rsi
 588:	01 f0                	add    %esi,%eax
 58a:	83 d0 00             	adc    $0x0,%eax
 58d:	89 c6                	mov    %eax,%esi
 58f:	66 31 c0             	xor    %ax,%ax

Surprisingly, this inlining does not seem to bloat kernel text size.
It at least two cases[1], it either has no effect or results in a
slightly smaller kernel.

1. https://lore.kernel.org/all/CANn89iJzcb_XO9oCApKYfRxsMMmg7BHukRDqWTca3ZLQ8=
HT0iQ@mail.gmail.com/

[ dhansen: add justification and note about lack of kernel bloat ]

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251113154545.594580-1-edumazet@google.com
---
 arch/x86/include/asm/checksum_64.h | 45 +++++++++++++++++++++--------
 arch/x86/lib/csum-wrappers_64.c    | 22 +--------------
 2 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checks=
um_64.h
index 4d4a47a..5bdfd2d 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -9,6 +9,7 @@
  */
=20
 #include <linux/compiler.h>
+#include <linux/in6.h>
 #include <asm/byteorder.h>
=20
 /**
@@ -145,6 +146,17 @@ extern __wsum csum_partial_copy_nocheck(const void *src,=
 void *dst, int len);
  */
 extern __sum16 ip_compute_csum(const void *buff, int len);
=20
+static inline unsigned add32_with_carry(unsigned a, unsigned b)
+{
+	asm("addl %2,%0\n\t"
+	    "adcl $0,%0"
+	    : "=3Dr" (a)
+	    : "0" (a), "rm" (b));
+	return a;
+}
+
+#define _HAVE_ARCH_IPV6_CSUM 1
+
 /**
  * csum_ipv6_magic - Compute checksum of an IPv6 pseudo header.
  * @saddr: source address
@@ -158,20 +170,29 @@ extern __sum16 ip_compute_csum(const void *buff, int le=
n);
  * Returns the unfolded 32bit checksum.
  */
=20
-struct in6_addr;
+static inline __sum16 csum_ipv6_magic(
+	const struct in6_addr *_saddr, const struct in6_addr *_daddr,
+	__u32 len, __u8 proto, __wsum sum)
+{
+	const unsigned long *saddr =3D (const unsigned long *)_saddr;
+	const unsigned long *daddr =3D (const unsigned long *)_daddr;
+	__u64 sum64;
=20
-#define _HAVE_ARCH_IPV6_CSUM 1
-extern __sum16
-csum_ipv6_magic(const struct in6_addr *saddr, const struct in6_addr *daddr,
-		__u32 len, __u8 proto, __wsum sum);
+	sum64 =3D (__force __u64)htonl(len) + (__force __u64)htons(proto) +
+		(__force __u64)sum;
=20
-static inline unsigned add32_with_carry(unsigned a, unsigned b)
-{
-	asm("addl %2,%0\n\t"
-	    "adcl $0,%0"
-	    : "=3Dr" (a)
-	    : "0" (a), "rm" (b));
-	return a;
+	asm("	addq %1,%[sum64]\n"
+	    "	adcq %2,%[sum64]\n"
+	    "	adcq %3,%[sum64]\n"
+	    "	adcq %4,%[sum64]\n"
+	    "	adcq $0,%[sum64]\n"
+
+	    : [sum64] "+r" (sum64)
+	    : "m" (saddr[0]), "m" (saddr[1]),
+	      "m" (daddr[0]), "m" (daddr[1]));
+
+	return csum_fold(
+	       (__force __wsum)add32_with_carry(sum64 & 0xffffffff, sum64>>32));
 }
=20
 #define HAVE_ARCH_CSUM_ADD
diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index f4df4d2..831b711 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -68,25 +68,3 @@ csum_partial_copy_nocheck(const void *src, void *dst, int =
len)
 }
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
=20
-__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
-			const struct in6_addr *daddr,
-			__u32 len, __u8 proto, __wsum sum)
-{
-	__u64 rest, sum64;
-
-	rest =3D (__force __u64)htonl(len) + (__force __u64)htons(proto) +
-		(__force __u64)sum;
-
-	asm("	addq (%[saddr]),%[sum]\n"
-	    "	adcq 8(%[saddr]),%[sum]\n"
-	    "	adcq (%[daddr]),%[sum]\n"
-	    "	adcq 8(%[daddr]),%[sum]\n"
-	    "	adcq $0,%[sum]\n"
-
-	    : [sum] "=3Dr" (sum64)
-	    : "[sum]" (rest), [saddr] "r" (saddr), [daddr] "r" (daddr));
-
-	return csum_fold(
-	       (__force __wsum)add32_with_carry(sum64 & 0xffffffff, sum64>>32));
-}
-EXPORT_SYMBOL(csum_ipv6_magic);

