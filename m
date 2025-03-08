Return-Path: <linux-tip-commits+bounces-4074-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCE8A57A9A
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9452B1890031
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5172B1CAA67;
	Sat,  8 Mar 2025 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h+P6rHXM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IkmraJwz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4B17A2EF;
	Sat,  8 Mar 2025 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441501; cv=none; b=Th293BpEBxj7QAOQksASaz4s4edJth61EguOSzNnv0YsfTOmCetoGDRvYKBSx5807u9ELb30+0/YP0qtpXjSQr+3yZGQwVYvSLGUXYdRBhE2aeEi1t44mZCo9KXzq5MIojOMivrnSElyToFryM3zemFtrKNxTWJiIOIA9aauMi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441501; c=relaxed/simple;
	bh=dnYxV+VG4f/AIIYc6bYQ2CMCBhnirgeGxPOu5sWUUbQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nBJVHMP3EEM/D45tOQz+/5oSSkGfTN9YJ8vT1UuNbuip3nWx+mv/7jDWyjWVGjCSdM58rFfswhQdnIWQNyfJTUYESqDXqHH+urbMR+u8fKhcivH8ctcVZUCjQY/q7nuXlZo8V2cieli8PqVseiDWclc4nnhCJShyz10ZrCEGWK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h+P6rHXM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IkmraJwz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:44:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MguDmraJV0zNSKmQB9z5Rg04WrOcvjCgEQjC19X1m6k=;
	b=h+P6rHXMrJSzHPi788n9A6S6np1eLIOQ1mADzKSuzbpxW/AP7+KDpYmS1tZqKm1vyLJe/3
	i9le4wDvooXpk73rmojOLme4/rFNsfQGq68BoQ1DzQP8T/LRr6Ymfvcy7cg24L0DwdTo+b
	XfwGe2vLiDq847/cFAAP8pybL02SmZwmGS64XHytj6kJrQR5ccFtOUBwx2JreHEmy/hIf0
	rd8r7yT4yeaP8djKKkvG9jJ3XCY0h2CQqzzSiJRrW9RhRa3SU2Y0Z3kZaZ4dyt9qOCEM8v
	BXjMunc9jh3Z0Bou8t1cIv0lsJzFgLUHFTDg60sSelnCdmfzaM2yJzNAz95XeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MguDmraJV0zNSKmQB9z5Rg04WrOcvjCgEQjC19X1m6k=;
	b=IkmraJwzuekB/K92/XH7eUmhCOxoS+TBhsr60YvtAtIUaqmmk6y5CjtnVpd+emwEwMsy1a
	vD3BzA/0Z5FNy+Aw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] vdso: Move architecture related data before basetime data
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303-vdso-clock-v1-18-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-18-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144149685.14745.11465984232089173625.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     97a5a90ca234eaa3de8a6aa44d43de2827393019
Gitweb:        https://git.kernel.org/tip/97a5a90ca234eaa3de8a6aa44d43de28273=
93019
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:41 +01:00

vdso: Move architecture related data before basetime data

Architecture related vdso data is required in the fast path when reading
CLOCK_MONOTONIC or CLOCK_REALTIME. At the moment, this information is
located at the end of the vdso_time_data structure, which is a suboptimal
cache layout.

Move the architecture specific VDSO data right before the basetime
information, which is always required. This change does not have an impact
on architectures with CONFIG_ARCH_HAS_VDSO_DATA=3Dn. Architectures, which
have it enabled, gain a better cache layout.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-18-c1b5c69a166f@linu=
tronix.de

---
 include/vdso/datapage.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 1df22e8..bcd19c2 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -70,6 +70,8 @@ struct vdso_timestamp {
=20
 /**
  * struct vdso_time_data - vdso datapage representation
+ * @arch_data:		architecture specific data (optional, defaults
+ *			to an empty struct)
  * @seq:		timebase sequence counter
  * @clock_mode:		clock mode
  * @cycle_last:		timebase at clocksource init
@@ -83,8 +85,6 @@ struct vdso_timestamp {
  * @tz_dsttime:		type of DST correction
  * @hrtimer_res:	hrtimer resolution
  * @__unused:		unused
- * @arch_data:		architecture specific data (optional, defaults
- *			to an empty struct)
  *
  * vdso_time_data will be accessed by 64 bit and compat code at the same time
  * so we should be careful before modifying this structure.
@@ -105,6 +105,8 @@ struct vdso_timestamp {
  * offset must be zero.
  */
 struct vdso_time_data {
+	struct arch_vdso_time_data arch_data;
+
 	u32			seq;
=20
 	s32			clock_mode;
@@ -125,8 +127,6 @@ struct vdso_time_data {
 	s32			tz_dsttime;
 	u32			hrtimer_res;
 	u32			__unused;
-
-	struct arch_vdso_time_data arch_data;
 } ____cacheline_aligned;
=20
 #define vdso_clock vdso_time_data

