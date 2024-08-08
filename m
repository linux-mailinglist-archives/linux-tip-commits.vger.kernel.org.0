Return-Path: <linux-tip-commits+bounces-1993-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C4294BAC6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 12:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFA41C20A7C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 10:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE7D189F55;
	Thu,  8 Aug 2024 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cd+0mBrS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d4r4MhJ8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E4D189BB3;
	Thu,  8 Aug 2024 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112566; cv=none; b=rAXIIrn+Xum8HCDgkc+0/kJMjUTqbqCMxFPg61vIdk3VtwPxWIwPTyNaVu6UifD4sVOx+k63wGijOsdYU46HegaF2LppRXu3gk/BBlJgAmK4SNMSo03aY9KTA3I9oEGLLZOoQXoitmCN3NO6G4dxp8WhXncop64UOhg4KjWSDEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112566; c=relaxed/simple;
	bh=Kc0UDuzjZAgcWewniQmSlwojX0uFoVMznBlPe0S72RE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MXuTZInqqWW/AYPH0AyhO4abFra/98FjvyDLW4qNnhpIjQgXArv5eikXz0o2hdJwq08DBzH4WnBW/igPmgNTCd72JVvb1x4eQ4ttj2fY/EKDSuY026SCBDY030Y44UKJ4DvpIpo3aJie5476I10P23LpIL2whsCebAGJwhZ0fHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cd+0mBrS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d4r4MhJ8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 10:22:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723112562;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kojillKZEkn6EDrj6PxY8PNWJk5WgD5GU1TmATCWqH4=;
	b=Cd+0mBrSzCEO+TFdSnSzbpdyXb3Qw1rGhOn4imYlLGsQ00/p6OHosUwlf4SCa+UYUlcnyB
	LjT+lkt1GcCz2Pxgh+eqCOKHEsmPVSoy6eLXM4xUIiXMxi1f5Q6wkrqikIoNwAKYIeao/5
	d58TVfYbOi+N7rgE+1Zc2gFgnj6d4gdryM8gSFQ9joIvGDpWlPNf4oxsFcjao5PiQtu77q
	AIlMVq3gULTATKNFoHo5aC9y7H0kV2ClmLkw05e2aN82O28J6uqKk5GmmaHzHabIH9fpZs
	tQ75GHcZ0xow0F/4CNOuTg2YyPjEU3gx2vSasEGM5azEL2utRVCLyCVako7Nvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723112562;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kojillKZEkn6EDrj6PxY8PNWJk5WgD5GU1TmATCWqH4=;
	b=d4r4MhJ8ROb4BbnAFXp/wVS4pW6+to8YkckoPBSOV7Fpe1dO0CWOJprzh7ZIKwitZgHFPO
	hoNTManKLuNqDYCA==
From: "tip-bot2 for Markus Elfring" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] locking/lockdep: Simplify character output in seq_line()
Cc: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Markus Elfring <elfring@users.sourceforge.net>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <e346d688-7b01-462f-867c-ba52b7790d19@web.de>
References: <e346d688-7b01-462f-867c-ba52b7790d19@web.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172311256201.2215.15188343375248414006.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     39dea484e2bb9066abbc01e2c5e03b6917b0b775
Gitweb:        https://git.kernel.org/tip/39dea484e2bb9066abbc01e2c5e03b6917b=
0b775
Author:        Markus Elfring <elfring@users.sourceforge.net>
AuthorDate:    Mon, 15 Jul 2024 10:42:17 +02:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Tue, 06 Aug 2024 10:46:43 -07:00

locking/lockdep: Simplify character output in seq_line()

Single characters should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D for one select=
ed call.

This issue was transformed by using the Coccinelle software.

Suggested-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/e346d688-7b01-462f-867c-ba52b7790d19@web.de
---
 kernel/locking/lockdep_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index e2bfb1d..6db0f43 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -424,7 +424,7 @@ static void seq_line(struct seq_file *m, char c, int offs=
et, int length)
 	for (i =3D 0; i < offset; i++)
 		seq_puts(m, " ");
 	for (i =3D 0; i < length; i++)
-		seq_printf(m, "%c", c);
+		seq_putc(m, c);
 	seq_puts(m, "\n");
 }
=20

