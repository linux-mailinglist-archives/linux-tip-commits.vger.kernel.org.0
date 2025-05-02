Return-Path: <linux-tip-commits+bounces-5202-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64450AA7A09
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 21:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FE53B36DD
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 19:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEC81F12FA;
	Fri,  2 May 2025 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2UqVy1hY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I4GFsysY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EBC1EFFA2;
	Fri,  2 May 2025 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212976; cv=none; b=OcEbEEsSYmw8kBY+IxeIzbGtLUOS34it6XgNGoZIyzJgVdrgYEnyP3SYJ/HKr54Yycw2hfpTiEwjKW2UrOUq+sUBf8iIhYNcwHg/EWRgGHtcb00kaHf57SV9xpn2m3w/W8dso/PKogjOgNXLhdkorz8xkfwGw8X8TE7nAIbI0Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212976; c=relaxed/simple;
	bh=MaT6m/oZyNFM8P+0xZFYFUmM26PLpT+c1agjvAb0MxI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mkWFhIHO5i07AoIaJAhT8q+hDYnRZvpC4dxFTlvvHdG3f6o12DgVEKgDN/zm261jJQ52sKl8iWjFhWaS3JhG/BEynNGtC30CQ3/BsJ2q+wTtAQ6UIqfSq2koI3QV75kh1sqt0r+OUv7SyuXlcMWK1dthP2OroIn/iSbJ4efZ4uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2UqVy1hY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I4GFsysY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 19:09:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746212972;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+P7xGI5GdriEKLGKPO6+wNOq1MXu9f1CdUtqMQ3jP4=;
	b=2UqVy1hYmWRUmbnqhBVVhkZrtRr12hr0iNJmzvPQmQ5PwAraSQeYNgxLret6AQX3gwbI9g
	hsNyOMqITu71dXXcChfmRZzO36TMadCSkka64iMHJm6nAazH0H9mbgoOgYAV26/WtScMpH
	FrIF1Z5/L9r8vloogKk/wQ4sCA+YiMmEz9lR2VVKXajkH9D/D+2T2uZ2Ox7XqLyAxBV/Y9
	A9/0u1gPR81SL3E4IsKQpshqhD4hVws9C59Lv1N18BmstRQ2mxCAk7jPP+cu9T8eowjZ4Z
	OrGDX+IEGE9KJFxUz43xA1irh+EOhiWnSxyyZKwxrdQxx1L7Vr7mE5kspJX9CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746212972;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+P7xGI5GdriEKLGKPO6+wNOq1MXu9f1CdUtqMQ3jP4=;
	b=I4GFsysY1H17jYgkJ4y8GIcgNyB0fCAHy7raQeNIysX8Nrm5/dUyAlkRIoaI2O8LVIiDCX
	EXd+egAyhQdR+dBQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] arm64: vdso: Work around invalid absolute
 relocations from GCC
Cc: Jan Stancek <jstancek@redhat.com>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250430-vdso-absolute-reloc-v2-1-5efcc3bc4b26@linutronix.de>
References: <20250430-vdso-absolute-reloc-v2-1-5efcc3bc4b26@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174621297192.22196.5751074600127323972.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     0c314cda93258cd1f0055a278a6576b5d4aeabf5
Gitweb:        https://git.kernel.org/tip/0c314cda93258cd1f0055a278a6576b5d4a=
eabf5
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 30 Apr 2025 11:20:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 May 2025 20:57:11 +02:00

arm64: vdso: Work around invalid absolute relocations from GCC

All vDSO code needs to be completely position independent.  Symbol
references are marked as hidden so the compiler emits PC-relative
relocations.

However GCC emits absolute relocations for symbol-relative references with
an offset >=3D 64KiB. After recent refactorings in the vDSO code this is the
case in __arch_get_vdso_u_timens_data() with a page size of 64KiB.

Work around the issue by preventing the optimizer from seeing the offsets.

Fixes: 83a2a6b8cfc5 ("vdso/gettimeofday: Prepare do_hres_timens() for introdu=
ction of struct vdso_clock")
Reported-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/all/20250430-vdso-absolute-reloc-v2-1-5efcc3bc4=
b26@linutronix.de
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D120002
Closes: https://lore.kernel.org/lkml/aApGPAoctq_eoE2g@t14ultra/
---
 arch/arm64/include/asm/vdso/gettimeofday.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/=
asm/vdso/gettimeofday.h
index 92a2b59..3322c70 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -99,6 +99,19 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock=
_mode,
 	return res;
 }
=20
+#if IS_ENABLED(CONFIG_CC_IS_GCC) && IS_ENABLED(CONFIG_PAGE_SIZE_64KB)
+static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_d=
ata(void)
+{
+	const struct vdso_time_data *ret =3D &vdso_u_time_data;
+
+	/* Work around invalid absolute relocations */
+	OPTIMIZER_HIDE_VAR(ret);
+
+	return ret;
+}
+#define __arch_get_vdso_u_time_data __arch_get_vdso_u_time_data
+#endif /* IS_ENABLED(CONFIG_CC_IS_GCC) && IS_ENABLED(CONFIG_PAGE_SIZE_64KB) =
*/
+
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */

