Return-Path: <linux-tip-commits+bounces-7160-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10476C28791
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1483AA968
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640463128AE;
	Sat,  1 Nov 2025 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1GHa02PI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sBw/fbLI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A5F3126A4;
	Sat,  1 Nov 2025 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026493; cv=none; b=YWUVsHI9A0tFyk/5CVbAVBrAA16bZ6Uft4+aW8rZlP6w+O6bJuKalBzcEt1lJaNrcTm6t57xvsdy9f2Ch5ut9lM/RG8GbyCTez86DFA5E/836SG/bS++SmfV4pRNYYODxIMmCK0swjAkjaKUrqkYOq81vgAujf5216m+/fi/nWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026493; c=relaxed/simple;
	bh=0o4M1MjgjDdo6m6t+yqDiaQr8S6i7vTCpnY6ZRXwEDE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a7CFO6I2tK5Q2YBg8HT21sqNedU6svzdi5NBmaGwiK301S5DPiNRZEPKVInrUOMeuHRu5N856Gk0RpYumPqg1ufANkbZsHAAeMfzuigTyhzdEAD47eUSpqbqF3/5PVRE61F3iDpxSqZTHhTq6+OvsIgGr6Ik4EvWPc+g/loyOvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1GHa02PI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sBw/fbLI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:48:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026490;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMnEpykBF8Dt5KH9iw6IZCRMkDtTgMn1izxTEx8QgnA=;
	b=1GHa02PIlDXuooyEb857o2vrG2vXhsUy/KPZz0L92bFEbD8cEQydtMipvJQqU5RYP3QYAd
	zKSUQ2i26CeM+yzHw6IVw6DQ64uUhrmpySX1JEXsnPG1mRhVaHQIypOjRtw/sjIUSPLn6x
	icEYtOxkN/fvnHSNLvxliLDPK6hZPHUUBDs4Rf2We+0zMbX8MfgUe/orcSDP5akFq1Vgir
	ULtjor4adSSwaMAwDQhClZKFv4hZ2FD55Vh7USiBLFKN29AkCHY6f76U5DXmIrTwqHb/wW
	epNh2RqoNcUl1xDhOv0Tt5XUoyYe3mGXVeaC69W9D2rUmx8JJxJLuDp9hQBMEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026490;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMnEpykBF8Dt5KH9iw6IZCRMkDtTgMn1izxTEx8QgnA=;
	b=sBw/fbLI9tsLP8Mz6gO5UusgRUZfGFQh3OHAJWfsr9DbLDEHhHF8rS/gaGL1kR7g/ACmoq
	jQNl3zgFYCKz/jBw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] powerpc/vdso/gettimeofday: Explicitly include
 vdso/time32.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-6-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-6-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202648919.2601451.210824174118016647.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     418c9643841b7a62b8251619b4cc7b36fd0a0709
Gitweb:        https://git.kernel.org/tip/418c9643841b7a62b8251619b4cc7b36fd0=
a0709
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:48:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:03 +01:00

powerpc/vdso/gettimeofday: Explicitly include vdso/time32.h

The usage of 'struct old_timespec32' requires vdso/time32.h. Currently
this header is included transitively, but that transitive inclusion is
about to go away.

Explicitly include the header.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-6-e0607bf49=
dea@linutronix.de
---
 arch/powerpc/include/asm/vdso/gettimeofday.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/incl=
ude/asm/vdso/gettimeofday.h
index ab3df12..b2f0e97 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -8,6 +8,7 @@
 #include <asm/barrier.h>
 #include <asm/unistd.h>
 #include <uapi/linux/time.h>
+#include <vdso/time32.h>
=20
 #define VDSO_HAS_CLOCK_GETRES		1
=20

