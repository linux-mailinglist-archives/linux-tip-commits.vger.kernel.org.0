Return-Path: <linux-tip-commits+bounces-6318-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34207B3213A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 19:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB1AB0672E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 17:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD84285C91;
	Fri, 22 Aug 2025 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bURNQzNe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mOKM/AHx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518C310624;
	Fri, 22 Aug 2025 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882563; cv=none; b=Vo8Fn53jiuY1O+1TYHFO+1M1Wz8E02MrFjA5Gu4NSsgGFbCZIowxj+0MmOGjvaDW/X8sQcllrrPq5ghOOZhnQFN+Lj2orLy0eNDL7JznKyWNsDBhyKJM+DM/al+PQwgcVslgac6hSgeudpnoNcLqxLjn2eIO51GrCqilPtdYn+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882563; c=relaxed/simple;
	bh=e82YW+vnS8YVDqwnueG7mFuKvNRgVYL3F30I7/mk7uk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jLmKUkDO7xmX0zJCZqJUbxERy+2ijnJ+6zOFMAUV9SD4s95YHWBDFC4DJ+RETNEBvjwe3v2Pu0av5xKHEE/O+Ae2cFYIaViolY6L47yRvg8o3Ut2t0bfli8oPljqfiMsGWHy7yl5lvRhEQzgroRzu/DipPsbtAI8Vgtu57V0E44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bURNQzNe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mOKM/AHx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Aug 2025 17:09:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755882560;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OxD7U2hmRz8MIwYxyoupDGyQvcsU7GxZsEfN8brXRY8=;
	b=bURNQzNeQO6axNBAnfDZ1I3pA/e3CD59Sle40fk7bflrVKFU8opLuAxhlCG4qW8+5IYSBr
	Wg7KLde2/ocmyyFvcqJqrD2W6MDz9/RH1G7kVyITYQC5/lJUpgK36ltEWP3Mi4aFeJn7sY
	yEp18n45AW7+SZMXdlw14LBbQs8xcrnHqKw2mK4RvpwM8Ciey07crx+I7OYaQ7WsceD+0E
	LHq4NpVAMnTo/yPoueMgy494gxAyJSf0SQp9HlGjO7P//ylaC+4EKCT0Ow/vQbv6dVNzyC
	WBluvXMCrV1czyR8Eit+8a/nsZ3LHpKDnsfomF/tNiQiZMm650/bBjX9by743Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755882560;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OxD7U2hmRz8MIwYxyoupDGyQvcsU7GxZsEfN8brXRY8=;
	b=mOKM/AHxiu+7SyCtMJr1gtAntD0kmxZVIwnpl6JUfkbQKht/OYShDA6S1AeZORfa1lUZAI
	clBXZpwWWjAoiRAA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/asm: Use RDPKRU and WRPKRU mnemonics in
 <asm/special_insns.h>
Cc: Uros Bizjak <ubizjak@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250616083611.157740-1-ubizjak@gmail.com>
References: <20250616083611.157740-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175588255895.1420.13540168684035053080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     966f504977e3a04fcadbaf199e3302e95e8958b7
Gitweb:        https://git.kernel.org/tip/966f504977e3a04fcadbaf199e3302e95e8=
958b7
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 16 Jun 2025 10:35:57 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 22 Aug 2025 18:54:07 +02:00

x86/asm: Use RDPKRU and WRPKRU mnemonics in <asm/special_insns.h>

Current minimum required version of binutils is 2.30, which supports RDPKRU a=
nd
WRPKRU instruction mnemonics.

Replace the byte-wise specification of RDPKRU and WRPKRU with these proper
mnemonics.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/20250616083611.157740-1-ubizjak@gmail.com
---
 arch/x86/include/asm/special_insns.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/spec=
ial_insns.h
index fde2bd7..c999145 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -75,9 +75,7 @@ static inline u32 rdpkru(void)
 	 * "rdpkru" instruction.  Places PKRU contents in to EAX,
 	 * clears EDX and requires that ecx=3D0.
 	 */
-	asm volatile(".byte 0x0f,0x01,0xee\n\t"
-		     : "=3Da" (pkru), "=3Dd" (edx)
-		     : "c" (ecx));
+	asm volatile("rdpkru" : "=3Da" (pkru), "=3Dd" (edx) : "c" (ecx));
 	return pkru;
 }
=20
@@ -89,8 +87,7 @@ static inline void wrpkru(u32 pkru)
 	 * "wrpkru" instruction.  Loads contents in EAX to PKRU,
 	 * requires that ecx =3D edx =3D 0.
 	 */
-	asm volatile(".byte 0x0f,0x01,0xef\n\t"
-		     : : "a" (pkru), "c"(ecx), "d"(edx));
+	asm volatile("wrpkru" : : "a" (pkru), "c"(ecx), "d"(edx));
 }
=20
 #else

