Return-Path: <linux-tip-commits+bounces-4193-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3EBA5F27F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B07618949FF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C94267B73;
	Thu, 13 Mar 2025 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sMZd3C4Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VsUjP5QB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC57267AEE;
	Thu, 13 Mar 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865497; cv=none; b=gHEdbN9zaip/1p7uq8X1znJ0hPiOu+3uHWgCvlJ/Kj0NqIoesaLtMdPPHy9vhVSTiNAeT33Xs/Sg+TEttgx0Potlb6lhyjJHcLYaTLovQgiay3DxKpfTk5R5Se2l63qYDBEd93wAurL9pmelVvNkUBFp/ge0SXjAtqwKR8bFjQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865497; c=relaxed/simple;
	bh=07vZg8Y145kRUGRKo5SSH7ACTRUtpkUWY5UYe4hZnno=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O2/1pXhN+RteqZMyHNQjdD/vp2xqzYkSHvfNhhgY+hyXbdRoAScT7hWirubh1ZJT1cUfO4HHCUtOu+EnGXwGDivuNES+n+kUs91cRP7FlGAQS72VV28itFkoIBFvtJ4fCLdjQn/aoips9nWtcQcxdO5ZdmTWkJYp1lWaM2N65Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sMZd3C4Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VsUjP5QB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCNVD+UUuHumJ/5fJhvmi0s0GXUO1DgRxKVqz2U3Eh8=;
	b=sMZd3C4YuSQI3fGZCAlzd/JCBwegj882E8Ezb+tg6/xPLKTPLrtRKLs8zJoplUBxFSRbt3
	8f6RuJcnFTQq9S16VwnHgH1DReoMomZnGS+Fofok2nIzXM58fRQsIjOEfDWl+yU7D2L4sk
	smlSYSTYaUl63sgL2NdQ0klyW+r34VHJRybLDIHtMYXJNO4kUzIAPUGeCu7rU2CgY1UNGZ
	tQpzV6X3jC/zZzTcN22OeWczWYQ2mpcCAkU+0I6+yZj+PPvuD/bT2K/VV5MNxNRxMnGydG
	3f4k4sW9t9bjolvdzDiq4rNWcVFXL/1RpFI3AVXq6G4rr+1wVc1ya76A8mcM3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCNVD+UUuHumJ/5fJhvmi0s0GXUO1DgRxKVqz2U3Eh8=;
	b=VsUjP5QByMwO+qQOCowtemm+28MWKpTKxvUnPpe1mdp0xj424EN2CWjiNTceE+WnVBMEu8
	X5a7MLJ4XyHoD9Cw==
From: "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Add cond_resched() to
 posix_timer_add() search loop
Cc: Eric Dumazet <edumazet@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250308155623.635612865@linutronix.de>
References: <20250308155623.635612865@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186549360.14745.8639976419196139513.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5f2909c6cd13564a07ae692a95457f52295c4f22
Gitweb:        https://git.kernel.org/tip/5f2909c6cd13564a07ae692a95457f52295c4f22
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Sat, 08 Mar 2025 17:48:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:16 +01:00

posix-timers: Add cond_resched() to posix_timer_add() search loop

With a large number of POSIX timers the search for a valid ID might cause a
soft lockup on PREEMPT_NONE/VOLUNTARY kernels.

Add cond_resched() to the loop to prevent that.

[ tglx: Split out from Eric's series ]

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250214135911.2037402-2-edumazet@google.com
Link: https://lore.kernel.org/all/20250308155623.635612865@linutronix.de


---
 kernel/time/posix-timers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 24d7eab..de25253 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -144,6 +144,7 @@ static int posix_timer_add(struct k_itimer *timer)
 			return id;
 		}
 		spin_unlock(&hash_lock);
+		cond_resched();
 	}
 	/* POSIX return code when no timer ID could be allocated */
 	return -EAGAIN;

