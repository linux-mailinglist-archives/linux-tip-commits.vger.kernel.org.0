Return-Path: <linux-tip-commits+bounces-7153-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EA4C28755
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BA9E4F2E8E
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C2D30E85C;
	Sat,  1 Nov 2025 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GTGvuSBz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WCEOB6RO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209D930E0C3;
	Sat,  1 Nov 2025 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026484; cv=none; b=Jh1rwnWO2Z/AE96xd2QH41rQkvyr9uyu6VTDEB90G8ElG4AcJdKDsUKKM97fVfI5pX1cLWQlm7e0/H+1zEz4fxwHCKPXqx/TjlO8kJNxeaErnrgRjxemS2Gam8GTl+dEFRxmbe8j7Wnp2WZeqG2vv/qGZqd4+KBI2x34YNg1+4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026484; c=relaxed/simple;
	bh=PtW+FaKor1UJHWr5w41q0HSep7zswmjxTN8fluMY7Vw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JEuuEiQOUJ3QoKQyhcLbgUDgKoSRzH7NSBKwiTF8vR7+fxF2xi/AtTZwQ0hbhVJ2JedI4O95fjMb6RF5rxbAOLskEdD4VtcP8rZAPcJ+by214lyDXKDAmxEWdl9tCcW3d5T3pqAkCJ5hYI4HbZmfcrP3kk9YETHKXNaNwDTCJyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GTGvuSBz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WCEOB6RO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:48:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NGM6a/iwrOdx48E1Ampd3MRsf93z3plL1DopvFlvSs=;
	b=GTGvuSBz1oGx//Ah1SqeCucxjyrGMBS3ejBLiMYq+sutArsuQd9YtW2GMk1VZbnecBgt9a
	eHCFajh2AEOSjdRZ68hupPlqHUSp5kJblHXkDf5q1OwISOh8afUsaeGSdRU3zemBpMkuQ5
	nYxPr9o+su5hBp1r8XkyjVARkLqOaufkX3AVXv5QYvmjGJFRadwo77QdJjt0MK1J7WJ4B3
	r1/6nGzFdu5p8GZWSr/nkwUyz/WrNnK1ZanUkgrR+usK4HvkdijBp283QywM/0BnMZXOx4
	oXOPfVXHc5WoXfdqNBDLewaayRiWlVMzgx8FSqvyIqw9MjQWSdvLwHlnjlxWlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NGM6a/iwrOdx48E1Ampd3MRsf93z3plL1DopvFlvSs=;
	b=WCEOB6ROxj7QGAWGxqB8VA0uCtdoWsbQw7Pr3x6NzvOU/tFv4HC20mF5AnGgx9ZJ/tdONk
	t++V9sj+SAYzLFCA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/helpers: Explicitly include vdso/processor.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-13-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-13-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202648048.2601451.8514382098151443503.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     bcde5a37ed7419c8d7e513d02c0b2949dfcf7998
Gitweb:        https://git.kernel.org/tip/bcde5a37ed7419c8d7e513d02c0b2949dfc=
f7998
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:48:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:04 +01:00

vdso/helpers: Explicitly include vdso/processor.h

The usage of cpu_relax() requires vdso/processor.h. Currently
this header is included transitively, but that transitive inclusion is
about to go away.

Explicitly include the header.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-13-e0607bf4=
9dea@linutronix.de
---
 include/vdso/helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 1a5ee9d..a1c995a 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -6,6 +6,7 @@
=20
 #include <asm/barrier.h>
 #include <vdso/datapage.h>
+#include <vdso/processor.h>
=20
 static __always_inline u32 vdso_read_begin(const struct vdso_clock *vc)
 {

