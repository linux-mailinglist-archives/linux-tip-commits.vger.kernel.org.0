Return-Path: <linux-tip-commits+bounces-3572-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F86A3F7B7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 15:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C81423CA6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 14:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CCE7080D;
	Fri, 21 Feb 2025 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bMISUSnM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MNJTTjvs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922453AC;
	Fri, 21 Feb 2025 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149348; cv=none; b=dwvUFOpr0xl1p+GIFnb3d8d2wuxOBP7DnR67/1EXTkHoldYkfEj/la1z2Se+dw94/yIigcJXr0Q3pGZv8ni5pXjZZn7RusYryS8h1GhSRYXe9fhSmChU3pcNxKD3HULnIukK18TYaLUpmMU02hlIqlnn9Q+solUWJjUtbec3HDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149348; c=relaxed/simple;
	bh=6y5aSOu9XdxgtAIeWMd/qbDJacafNJAX34rjFItQqvc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CB/6mpf908NxbpgF4l4x5CvL+SRmZYSeOgbbhmf06+gyNKiJRxgg7ku0+YtVWp8CfcTTOU3oK8uBdiIuIJdOklLcVgO222HQhlrW4YvSj6hUU1sNg9Io//yYgmwnwFRymVTaLFm3lUazVqg1PkeZdFfDSPna+jzGoJV5eogr/lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bMISUSnM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MNJTTjvs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 14:49:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740149344;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJdEXL+TIqNWTihDfZVUb+0icsv0CT4eBIrIVcULeIc=;
	b=bMISUSnMq8iHjytGnhs7cGFvje3YSHGuzN0GZWuIhbNXTVvibdczuLiU7yVP/AqMaLY8yv
	Tof5IKfE4CxMyaKYp4J9jMLeA0g+k6T2jhprBx9BmGxSXv5wRIZYd1ZeqeltNA8E/Wg7it
	lY3waIO1u9cjH5V5oJuDmDVhr2i1ULbm9GHOf/f5LvaPqpB5BGt5AxfLgs0mGmHtl+6V3K
	BW6SeXoLGETFiG8VP6kL7VE+6mKB9OHfnZyFRr1a+vERjz8d3u4Yn8mmOlUTH7ZPHAxhVZ
	jm1wDPpahUsv0hLzxkmHlZ9VKJ29wcAbXqASV6adhD5CzdMhLiayWwtREZ3AKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740149344;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJdEXL+TIqNWTihDfZVUb+0icsv0CT4eBIrIVcULeIc=;
	b=MNJTTjvs7qPJMn2dtpa4NA8HivCcC3sLdhucI0VLdAF5gEd0leqyrEOI+kMLi6QDkaXjH3
	gNhNJlZsKGgmUpBw==
From: "tip-bot2 for Qasim Ijaz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Replace open-coded gap bounding with clamp()
Cc: Qasim Ijaz <qasdev00@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250215125249.10729-1-qasdev00@gmail.com>
References: <20250215125249.10729-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174014934373.10177.13398467994659612713.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     282f395244df3663dc24e97a86087431c9192513
Gitweb:        https://git.kernel.org/tip/282f395244df3663dc24e97a86087431c9192513
Author:        Qasim Ijaz <qasdev00@gmail.com>
AuthorDate:    Sat, 15 Feb 2025 12:52:49 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 15:33:57 +01:00

x86/mm: Replace open-coded gap bounding with clamp()

Rather than manually bounding gap between gap_min and gap_max,
use the well-known clamp() macro to make the code easier to read.

Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250215125249.10729-1-qasdev00@gmail.com
---
 arch/x86/mm/mmap.c |  9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index b8a6fff..5ed2109 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -84,7 +84,6 @@ static unsigned long mmap_base(unsigned long rnd, unsigned long task_size,
 {
 	unsigned long gap = rlim_stack->rlim_cur;
 	unsigned long pad = stack_maxrandom_size(task_size) + stack_guard_gap;
-	unsigned long gap_min, gap_max;
 
 	/* Values close to RLIM_INFINITY can overflow. */
 	if (gap + pad > gap)
@@ -94,13 +93,7 @@ static unsigned long mmap_base(unsigned long rnd, unsigned long task_size,
 	 * Top of mmap area (just below the process stack).
 	 * Leave an at least ~128 MB hole with possible stack randomization.
 	 */
-	gap_min = SIZE_128M;
-	gap_max = (task_size / 6) * 5;
-
-	if (gap < gap_min)
-		gap = gap_min;
-	else if (gap > gap_max)
-		gap = gap_max;
+	gap = clamp(gap, SIZE_128M, (task_size / 6) * 5);
 
 	return PAGE_ALIGN(task_size - gap - rnd);
 }

