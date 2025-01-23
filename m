Return-Path: <linux-tip-commits+bounces-3280-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2FAA1A243
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jan 2025 11:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90C0165D93
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jan 2025 10:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0B920DD68;
	Thu, 23 Jan 2025 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WM10uMlG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pvhQAts2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B29A20D516;
	Thu, 23 Jan 2025 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737629857; cv=none; b=XnutJ+n+c2d93LZWuo7GbIoRpZqMDSDx9T6GLrmGZDPmviHUJ8qSTbg+MizsWC8j2zchZyUnZQYDG/5T8hUTUsDXchFE6DLJS8mZiIsKnlk4G22nmTo2sVSXmFxubZ42O6dT6pnGNB2QisOpX5juKcSS9Lkha7IVxdu2oAPfgrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737629857; c=relaxed/simple;
	bh=iuKdcrR087cvSQzC5n0duTPfz/S9BYCE1WUc0NyBWLo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A2EpYvlLEJMAqpRuAMpQTaW9iUlfodOyhwNxEl83vUzu5jEGVl6JkKp4BaHETawpBJV8FXPFdTcuVuBQbaPryZ7UqD6mpLYUa/SotK7gubemnKMxDzpRvsbDKFVSztAXJJ3iyD4hzzZZaEBuhLekRf5WOJMZdwB3Xe3We2mJYJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WM10uMlG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pvhQAts2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 23 Jan 2025 10:57:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737629853;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UrPuOi9Q2ZPaDV+lLu4sxg01QVA+sCF6KGZ2pxq/T4o=;
	b=WM10uMlGM+RDBeYUM6Y+h15N+gxA+Qv93o9YTFJZzOiS0Y8nLH7MAHRS4+i0bfxmMIkViz
	02vJz/D/7e6waWUAhZAWxGRyeXTom8ce9FjCILXMH+jWAIpUCD43y7sIOt7nAT6PZvH5yd
	w0/4pbVkGdG9EW17zPAgHpU0nm9KpST97ODqIhSea9K1edSffGe//sm/HvxD2VeQe+rp65
	XKwEaEZl+gOQGb6dT5frxBHKVYE+969G0+SXptXdJlFYB9P38dY9VuuLEm0Xx08GWNaI9Q
	VyW1/Z8csSDmCwRU7gPcw8l/zXD5XEA9zmHtRoXestg5PEc+VD3lAYHjtx6EZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737629853;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UrPuOi9Q2ZPaDV+lLu4sxg01QVA+sCF6KGZ2pxq/T4o=;
	b=pvhQAts2s4BASp/lU0F4QDynlL7/AABym206N8Ez4WwlHhuzggKrBjDBdRpXKf1UFRHnIV
	vQ127JDpPKMvEHCQ==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] hrtimers: Mark is_migration_base() with __always_inline
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250116160745.243358-1-andriy.shevchenko@linux.intel.com>
References: <20250116160745.243358-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173762985287.31546.13973652433600504292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     3ff6e36be060f0a8870f76155e14de128058b964
Gitweb:        https://git.kernel.org/tip/3ff6e36be060f0a8870f76155e14de128058b964
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Thu, 16 Jan 2025 18:07:45 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Jan 2025 11:47:23 +01:00

hrtimers: Mark is_migration_base() with __always_inline

When is_migration_base() is unused, it prevents kernel builds
with clang, `make W=1` and CONFIG_WERROR=y:

kernel/time/hrtimer.c:156:20: error: unused function 'is_migration_base' [-Werror,-Wunused-function]
  156 | static inline bool is_migration_base(struct hrtimer_clock_base *base)
      |                    ^~~~~~~~~~~~~~~~~

Fix this by marking it with __always_inline.

[ tglx: Use __always_inline instead of __maybe_unused ]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250116160745.243358-1-andriy.shevchenko@linux.intel.com

---
 kernel/time/hrtimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f6d8df9..14bd09c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -145,7 +145,7 @@ static struct hrtimer_cpu_base migration_cpu_base = {
 
 #define migration_base	migration_cpu_base.clock_base[0]
 
-static inline bool is_migration_base(struct hrtimer_clock_base *base)
+static __always_inline bool is_migration_base(struct hrtimer_clock_base *base)
 {
 	return base == &migration_base;
 }
@@ -275,7 +275,7 @@ again:
 
 #else /* CONFIG_SMP */
 
-static inline bool is_migration_base(struct hrtimer_clock_base *base)
+static __always_inline bool is_migration_base(struct hrtimer_clock_base *base)
 {
 	return false;
 }

