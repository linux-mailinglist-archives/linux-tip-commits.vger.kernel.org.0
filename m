Return-Path: <linux-tip-commits+bounces-7157-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C46CC2876A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314BC3A34AA
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03683112DC;
	Sat,  1 Nov 2025 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nxJkoLZ+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7lcpnWSk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFC73101A9;
	Sat,  1 Nov 2025 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026489; cv=none; b=tubiIDGWuOWWM5I+TpMuyNBRIebe+l87bxWjUe3b/QPATFIFAR1RGKQBj4tsDKA3b/38xIROKy3GdH6G8+7OxzPcgqru64zpHnrZqcNldQavnGTY2QSi2Jk3WkKjSLu1iKkXKk+4Vbtur0ioDRdCJ3YMvNIxbgFQlAZaFKozYmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026489; c=relaxed/simple;
	bh=9ojWGL8msG1hb7W3oA7SxplAlIcEdF6i9bwz63wDcaE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fQKn1/U5IJ/Pg0indOTS+9GGSiH1afohgfXS8fkIWmpGf+/YaPJu2OWvXN3g/b2WOhSj01Zzh7CEa+ifuExgwjKoWSeP/2E+H+nD2FtOwiUA2XsJCyn48aM0jlVkfPrg08ZajcmKNbe2GBZ5oCO13iyNz4CRxgwLXIHsHyNHLh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nxJkoLZ+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7lcpnWSk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:48:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8s7/DeSTxt1x/JHj4YvfVBPmHvQLwJTnfqMNSm8/ZYs=;
	b=nxJkoLZ+G/bttrIqe+UChc2PJPcmPya6aRPd1m77VzX8mJ7x5Uzlh/ZYxkIpnagWti2qWa
	7zDiKHpYyml3ma/lHKCxDqVvZT+rOwqHoAceaoNRprs3dgWhOsxYYHhD/h7EBw3/sHH+du
	M8edtRnjywJn6m1rggbdOD171yupDJg7y7p0UIbzspxAIcUUHuUvpeVtFw9ZekszFyE4gq
	nGJCQlaiReGG82+nrPFDXrInFTJj5AvGy6wiekX7fLl8MQdfVzUxdPpuiCWovQPsvfQ51D
	8Ec+lXmEreeohaQgLjXIcjkD7q6uZVtb7pzBsckFXba0QSxPGFnDN+uzFgs6LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8s7/DeSTxt1x/JHj4YvfVBPmHvQLwJTnfqMNSm8/ZYs=;
	b=7lcpnWSkk7nIucAdJQPwcGgODHM5l9mc876b7YVWyskZsQ/sZ2OhbLCpOLUW+TB4gVb2R5
	+t6HoStTcmYruPAA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] MIPS: vdso: Add include guard to asm/vdso/vdso.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-9-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-9-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202648552.2601451.16859901866753916543.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     a25a6ed869cc4f9b8af18446c2c6b4f8d20988f5
Gitweb:        https://git.kernel.org/tip/a25a6ed869cc4f9b8af18446c2c6b4f8d20=
988f5
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:48:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:03 +01:00

MIPS: vdso: Add include guard to asm/vdso/vdso.h

An upcomming patch will lead to the header file being included multiple
times from the same source file.

Add an include guard so this is possible.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-9-e0607bf49=
dea@linutronix.de
---
 arch/mips/include/asm/vdso/vdso.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/vdso/vdso.h b/arch/mips/include/asm/vdso/v=
dso.h
index 6889e0f..ef50d33 100644
--- a/arch/mips/include/asm/vdso/vdso.h
+++ b/arch/mips/include/asm/vdso/vdso.h
@@ -4,6 +4,9 @@
  * Author: Alex Smith <alex.smith@imgtec.com>
  */
=20
+#ifndef __ASM_VDSO_VDSO_H
+#define __ASM_VDSO_VDSO_H
+
 #include <asm/sgidefs.h>
 #include <vdso/page.h>
=20
@@ -70,3 +73,5 @@ static inline void __iomem *get_gic(const struct vdso_time_=
data *data)
 #endif /* CONFIG_CLKSRC_MIPS_GIC */
=20
 #endif /* __ASSEMBLER__ */
+
+#endif /* __ASM_VDSO_VDSO_H */

