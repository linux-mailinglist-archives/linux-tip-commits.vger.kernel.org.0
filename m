Return-Path: <linux-tip-commits+bounces-2729-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E2A9B9F9A
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04811F21970
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2839195811;
	Sat,  2 Nov 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G8h3PKzy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UfJpDWag"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B0D18A6BF;
	Sat,  2 Nov 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548220; cv=none; b=msx88jyCDxb0T1SoGkOY4ZLFJSdpUKy9BfdP9ua6ZrONINpxC7yYmM5HmeP9UHXx7veKjysAMdR/WOi/65e9NCLzLmPBRmB0LPPVJpgg3tib0IUpif/ZBNtET8Th2tHbAtP5xxHMLeJsaYe7VaVDBKJ63RbA6K+gzccK2zwGJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548220; c=relaxed/simple;
	bh=hZDO2oF21tTSYhLut1IgH//gLQ3+FXitwRWA2KPk65M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ctWIoYjMwTe2ugjNandj/CrKJI2Tz3D5Wc/uvgY3/jpgO7OoUkZwPWVv8Qs0TMHSjhsKK5SsBiMzBVx9wJ2QEGCBVfUQD1n8AgnqyT9NHyViQRoCEQgzBFs9h9UQV/QdBgSE+1tsKELPbIt2vpg7os49NIs6jS07esDDyMvUtGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G8h3PKzy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UfJpDWag; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548217;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLbS+skk8KAlk8SIocxMb+W2t2bZh8AAtRCvhzUuNYI=;
	b=G8h3PKzyLK3n63qBJijwpsNtST6OyoHZ7HHbYMklcx4tgI+mqkvubVtyAXoHEybsZSFDOa
	gFlqD4DSu1v2+WgV050RfV/liQ2VB1WCzGTNxVqdlBXcEA2bA3olMTqyV8i14YEDaAL7ra
	EmOxlaGGZZNBNPc01Ne6Phj2OhlrU1aNM6uIrklWTwbmnmRxregbluxPzbuKGzKjp0RnZp
	BfH/G0iKOMHDA1ISfBKnTdgwKT4lQelXwoRd/YRY2SQW43JbNh7XnrvOmRwrN+90TQn+26
	XLJ0vfBcFrZSAZplJKoAse1uLIAs4puk60RHUiW0fIJ5jiqmFFLMsqSZwfoctA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548217;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLbS+skk8KAlk8SIocxMb+W2t2bZh8AAtRCvhzUuNYI=;
	b=UfJpDWagX1ckRVl2FKZ4DwVoUXifm+arR+T5bQkIbu+pIR6oFZmHWZFQTDXws4Y3/qeb7F
	+Bk7Cg28m56c3jAA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] powerpc/vdso: Remove offset comment from 32bit
 vdso_arch_data
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-21-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-21-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054821664.3137.3798386279626073164.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     e449c83ac5b1d10cdde084e9d5da1902cde9e823
Gitweb:        https://git.kernel.org/tip/e449c83ac5b1d10cdde084e9d5da1902cde=
9e823
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:35 +01:00

powerpc/vdso: Remove offset comment from 32bit vdso_arch_data

This offset was copy-pasted from the systemcfg structure.
It has no meaning for the 32bit VDSO.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-21-b64f0842d5=
12@linutronix.de

---
 arch/powerpc/include/asm/vdso_datapage.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/=
asm/vdso_datapage.h
index 248dee1..3d5862d 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -92,7 +92,7 @@ struct vdso_arch_data {
  * And here is the simpler 32 bits version
  */
 struct vdso_arch_data {
-	__u64 tb_ticks_per_sec;		/* Timebase tics / sec		0x38 */
+	__u64 tb_ticks_per_sec;		/* Timebase tics / sec */
 	__u32 syscall_map[SYSCALL_MAP_SIZE]; /* Map of syscalls */
 	__u32 compat_syscall_map[0];	/* No compat syscalls on PPC32 */
 	struct vdso_data data[CS_BASES];

