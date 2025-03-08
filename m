Return-Path: <linux-tip-commits+bounces-4073-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09310A57A99
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D63016CF45
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3661C1C701B;
	Sat,  8 Mar 2025 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GsLEb/zr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/8YsDg5F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5481B4152;
	Sat,  8 Mar 2025 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441501; cv=none; b=Rc04vUEQVTjAMpKni8Ot7birrBW7Rp9J8mC7WFESbz83jIWr523wdYgagVgGKB5lQG/cQvyb/hKfpDBIwMFFn7exx3WfYE7IszEQg57wm3t+Cte3PIr1CA1EwI5FKlm7eoCg/2+fSL3ZDVWEAvboV6kTVbN1XsbGCHmGdXnEZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441501; c=relaxed/simple;
	bh=rrvgF9er4ytTDpd9u+FZrXAfRKVd4PQQKj8LMoV8Xko=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Irz3B4leZjoToXsRTNzMoBwJSa7Z6C5cdJEPafHfnHoQgGvdybHaD7C7cIHu1n+fzdGK2I7RFSsdVPvwJt+JnrMl/Ucpp1SIihwmkIns33+UUjl9A+QoFfkjmIdYBN1aYp4MRyk0/6C7KjizYzVJ7Atax8x6HOeir3DdPbFk9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GsLEb/zr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/8YsDg5F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:44:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441498;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfRJdQf67VbfEVO/9Kg+E5Q2D8llyuwGMTrnS68JPlo=;
	b=GsLEb/zrO7JRzKoO6pkoJS6uIzJDQSVPpOn5qhSKghnsxTr7gj4hx1bb3AfcT9F3/YN1gp
	N2ehLdG+AxvNFQfPec5Igv/phWKd57Rj499mdFuwRUDkTtsRG3y5sVihnwp5IzGTyalDNE
	kNjbvkuWh9xdsObIHzMLZAwNZA0phjcqnN6M7LS00ORJvvtHOOmp/6MYYzhJX/Zo9Mz4IG
	HxrBeG5YDs+gOinnhDEsMjdSYP9/HPt4LUuk+4+Rwn9tnMKONDg7hwARewQgrVq98hr77R
	hfx69eZxv/APBzR2Oy7Z7EPCjcb/iBQMLCx4ZNNpc/azw9SE1kA9hZ1zROCT/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441498;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfRJdQf67VbfEVO/9Kg+E5Q2D8llyuwGMTrnS68JPlo=;
	b=/8YsDg5F6HODAW+hwZcaEy7wBkv0D2T6S+IjonZagv/RSLPLJWEYclnYtrnbv+HEAgbfDP
	NKXnSBk3GNOykGCw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] powerpc/vdso: Prepare introduction of struct vdso_clock
Cc: Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303-vdso-clock-v1-17-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-17-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144149743.14745.4413631269943521746.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     ed0c10f34ffd94d6e0d37b830c232f7ca38ea174
Gitweb:        https://git.kernel.org/tip/ed0c10f34ffd94d6e0d37b830c232f7ca38=
ea174
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:41 +01:00

powerpc/vdso: Prepare introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of VDSO clocks. At the moment,
vdso_clock is simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer with a struct vdso_clock pointer where applicable.

No functional change.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-17-c1b5c69a166f@linu=
tronix.de

---
 arch/powerpc/include/asm/vdso/gettimeofday.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/incl=
ude/asm/vdso/gettimeofday.h
index dc955f2..99c9d6f 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -99,7 +99,7 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_=
mode,
 	return get_tb();
 }
=20
-static inline bool vdso_clocksource_ok(const struct vdso_time_data *vd)
+static inline bool vdso_clocksource_ok(const struct vdso_clock *vc)
 {
 	return true;
 }

