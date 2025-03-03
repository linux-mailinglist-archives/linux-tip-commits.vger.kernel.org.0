Return-Path: <linux-tip-commits+bounces-3825-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CCBA4CBBF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D119916D928
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9628A23957E;
	Mon,  3 Mar 2025 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dqc5asM+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7fe67Ojw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C423719E;
	Mon,  3 Mar 2025 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029185; cv=none; b=geWICmv1k2FctIDnW0Bu4x8ywxv6B51HanE+mKcvtcFOE34FzozoE81zZnCKF08wbwePYMeKAGWqaZeIBMNhXeXymCYPs3GG72Ve3D12gfTr7pThFEXWZT5aE7Lfd7OZIzSa1qwwrheP5D6VkKvBH+pZtQ46Yc/Vs+Vt7bGQQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029185; c=relaxed/simple;
	bh=8TrOaxFg76IClECN0wLJ5eLfpiQ9GTEJk7c1yAHjgig=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LDTEwHTNgKCQVlBb32cW30FitNszhiFxJJvpfaD1Rms2MwmX+6mS/hXHmgCVEkRbp8OQi31RrTaC2IQfFTyBdXSVd1yivwS6QJMDk5hTafcUeXRAseos1YDt8UKTKTf0n22NHCpBv6ULEVFroTQElP07558+IqhYls9x4oEusrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dqc5asM+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7fe67Ojw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:13:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741029182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmN8UFg+aMGVj8+TyaWzG7venv06Na8e+49PvqfTgbg=;
	b=dqc5asM+OGb2A0y7dOf4jNcWu6t/tvqk1BWnn+4RDxP5XXfopbmdwwCjj06OXnlxWYLzr6
	3N7WCSTTRQx/0PykCYJO5Err36hgiOqiu0L6dtcTzq41HMYXCu3dKrRDoOjzvy4ocGEVeI
	pB7kNMDHlNjkj5y6xVFKfpgG1KlTeDBQUWwj8LEdkGZ7N0v45Hf60pjkhKqKlVduW9Nu9W
	f2dxSq1NAX0lE9vKZyRs/yoPaXADQ5q0rx9DcTc1OIT49Fdg4EnkabVgN5cRNBhPKJLMOB
	Kj4dgO0Bqc5rniUkv16C7n5rhj2PxicSY66XYTdrIvf1B8WX0tuhW0ALo7iW6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741029182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmN8UFg+aMGVj8+TyaWzG7venv06Na8e+49PvqfTgbg=;
	b=7fe67Ojwgo6vS8quIJ21DV0j8Ey7LBbh704cPPeLllWcnmNlS3Pli7nEUtX3iB4+AIkCco
	O/CARC1Edf+WdRCA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] elf, uapi: Add types ElfXX_Verdef and ElfXX_Veraux
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Kees Cook <kees@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226-parse_vdso-nolibc-v2-6-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-6-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102918199.14745.13995480879251791212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     e0d15896f5dc90f4bd36ab79c958f6eff3f7f403
Gitweb:        https://git.kernel.org/tip/e0d15896f5dc90f4bd36ab79c958f6eff3f=
7f403
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 12:44:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 20:00:12 +01:00

elf, uapi: Add types ElfXX_Verdef and ElfXX_Veraux

The types are used by tools/testing/selftests/vDSO/parse_vdso.c.

To be able to build the vDSO selftests without a libc dependency,
add the types to the kernels own UAPI headers.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://refspecs.linuxfoundation.org/LSB_5.0.0/LSB-Core-generic/LSB-Cor=
e-generic/symversion.html#VERDEFEXTS
Link: https://lore.kernel.org/all/20250226-parse_vdso-nolibc-v2-6-28e14e031ed=
8@linutronix.de
---
 include/uapi/linux/elf.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 8846fe0..49f9f90 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -491,4 +491,34 @@ typedef struct elf64_note {
 /* Bits for GNU_PROPERTY_AARCH64_FEATURE_1_BTI */
 #define GNU_PROPERTY_AARCH64_FEATURE_1_BTI	(1U << 0)
=20
+typedef struct {
+  Elf32_Half	vd_version;
+  Elf32_Half	vd_flags;
+  Elf32_Half	vd_ndx;
+  Elf32_Half	vd_cnt;
+  Elf32_Word	vd_hash;
+  Elf32_Word	vd_aux;
+  Elf32_Word	vd_next;
+} Elf32_Verdef;
+
+typedef struct {
+  Elf64_Half	vd_version;
+  Elf64_Half	vd_flags;
+  Elf64_Half	vd_ndx;
+  Elf64_Half	vd_cnt;
+  Elf64_Word	vd_hash;
+  Elf64_Word	vd_aux;
+  Elf64_Word	vd_next;
+} Elf64_Verdef;
+
+typedef struct {
+  Elf32_Word    vda_name;
+  Elf32_Word    vda_next;
+} Elf32_Verdaux;
+
+typedef struct {
+  Elf64_Word    vda_name;
+  Elf64_Word    vda_next;
+} Elf64_Verdaux;
+
 #endif /* _UAPI_LINUX_ELF_H */

