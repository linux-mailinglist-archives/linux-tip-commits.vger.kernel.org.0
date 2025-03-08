Return-Path: <linux-tip-commits+bounces-4089-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AD0A57AB6
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9883B3559
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BC11EDA1D;
	Sat,  8 Mar 2025 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dbe7xUuK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2YgjodC8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95BA1B85E4;
	Sat,  8 Mar 2025 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441508; cv=none; b=gRio4uqb2bKHQzSVxxdiszux8WLYhTAGHmhKvWR/YTi9/ThS2wBRdT5DVKhBWbS/Q/jZZ+jSWPl56y0rI5UtLtUVaBpvUq/uNQGDdh78STU2Uz/dllzidE7FHmUjWWmTJbSPxta0DAJsyYM7zZ4RpXc4sYLJLZR9y0rk3Z7U3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441508; c=relaxed/simple;
	bh=W4Oo/51/wJgyxMDEDzwNNqandvCVp4f5uW6dNFkmsec=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UTgwWmNwHcxwE466WUWvRn5wI9F0iOPtl4paWT/qTQPIVwOAz4HR7mWhuqH/1ecbsx5APmTwUExoP5Pb8BVSSkOM/sACe/2d66zc2N4a5GkNQVB47Aedez96l2JIKwqH0cQPrk1Wztvb9faEvsJtZ9kAnQXRFUylUoxkAqPpEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dbe7xUuK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2YgjodC8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:45:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=967JvDkrjkNlOvLTi9yYgkajMSnuiWjUld0GQI7yYXQ=;
	b=dbe7xUuK/xTXtmcQao5N2qF9SiJriR0W0tzg8mGNyccl+YQ09pRNXABnMRG7yY0Potjx7R
	HYIsgZVEcx3ci21ZuQgowjXmjdNsNNVxQeE2Qlh0jx0CMsO6njbFbtfI5NLwY6HD8VFhR+
	OK81MnAiflSrP307Cbg9cD+fy0Zxkm3PejdxQ5qRYOA3YRNMAjcf5OUSuAaRm52zMb1iik
	f5MfJq2yOepytznIkwU+q0ZA8K3wk1oYNulZu8AGY4DPUEXp/7CFrRDydI9k8KMWF1dUSK
	Wy0M13Sy/O8OlhKe0aR/VoUwlHlxejLDUrSAwUil/914UeMt5QFHTk30Pg7DGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=967JvDkrjkNlOvLTi9yYgkajMSnuiWjUld0GQI7yYXQ=;
	b=2YgjodC8aQsM00Qn4l4I0AfmmtlFCH9ZD6Bsz/erBTT0EaUy79ou/ghTm6Y2lvEsaZKdX4
	xBROM1y7KfEYybCQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Make vdso_time_data cacheline aligned
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303-vdso-clock-v1-3-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-3-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144150476.14745.3291989061852271457.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     fa8152ca221110e14e43040bd442c8140bc2e03c
Gitweb:        https://git.kernel.org/tip/fa8152ca221110e14e43040bd442c8140bc=
2e03c
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:39 +01:00

vdso: Make vdso_time_data cacheline aligned

vdso_time_data is not cacheline aligned at the moment. When instantiating
an array, the start of the second array member is not cache line aligned.

This increases the number of the required cache lines which needs to be
read when handling e.g. CLOCK_MONOTONIC_RAW, because the data spawns an
extra cache line if the previous data does not end at a cache line
boundary.

Therefore make struct vdso_time_data cacheline aligned.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-3-c1b5c69a166f@linut=
ronix.de

---
 include/vdso/datapage.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index ed4fb4c..dfd98f9 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -11,6 +11,7 @@
=20
 #include <vdso/align.h>
 #include <vdso/bits.h>
+#include <vdso/cache.h>
 #include <vdso/clocksource.h>
 #include <vdso/ktime.h>
 #include <vdso/limits.h>
@@ -126,7 +127,7 @@ struct vdso_time_data {
 	u32			__unused;
=20
 	struct arch_vdso_time_data arch_data;
-};
+} ____cacheline_aligned;
=20
 /**
  * struct vdso_rng_data - vdso RNG state information

