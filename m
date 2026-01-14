Return-Path: <linux-tip-commits+bounces-7983-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD514D1E2DD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C56FB302A969
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BEA38F230;
	Wed, 14 Jan 2026 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gYCFS+hW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GbUL2+iU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361B83921F5;
	Wed, 14 Jan 2026 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387211; cv=none; b=lDMqugspyAr5Oj6CR2hFx3zPrHF6Nt1FAakEd5v+OUTHafuNfcAheUGMazQB5FSsTNHxHCQSibBSYuTV0/7inUUinIkBdOYQyiS6yTOy4Hi8LUGULYoc95F9sqRwQPW8W4uPbaIRPHwKo8C8Ppr5nMe0DhBSzk6w/XGkCkpCTjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387211; c=relaxed/simple;
	bh=BRmhiZqMSDUUIpJvUq347VNpOQeRqbA9BX+y50ffgXk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=abM5QxX7M0Olp+LvxWQiS730psAu1qbSk4Ijr95ml2oJtVNtOenT8CBRA/XK1KR7mUdNsLEoxOAw4TWOWAl6nD5HyXOx6M9QmOeIGkjqPwnJs9a5Xcvo2+v9/BA7xecGzA/2DPCY2vbb1pjAlz+dch3WypcbfRXjoe+LoraiCC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gYCFS+hW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GbUL2+iU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0yOgbsqlBQChTFpdIdaaIYqsixpTfww0VjbeMOtBFA=;
	b=gYCFS+hWvCb4iEXUC20vczi25l93KRs7luX4aNccY8fZNsxBrUI4tobmBlaWP2FE7rugXW
	3lqTp2iExS06rH9EVBmzO85PvzQrarSI4i9uv2QXGvKd9jz13GL6c5fLVnWbnXCD1nhf95
	CPAPJ8vowTawWOblX/i//ZNQ7kALJ+w8DqDDPd3N4oDiL6ctntqa2WuR6ye/yk2+gFC5RS
	WCvWtVzuUqjIMeZ1D2eUIUiWc55kgUM/oMuoEyKAyT0BdPA8vKFJQq0kSnImvmbpyPH0cI
	dPrdRfXBwM9g8EbaFPkWQ9zcL2JPLJmbcxJ1RLzbpYkZnwXqwaL/WsFb9WR1tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0yOgbsqlBQChTFpdIdaaIYqsixpTfww0VjbeMOtBFA=;
	b=GbUL2+iU8bLYSdsOaKPX/0vXZrbYCbYb9bG3bZiWMhERjyH2yYNHQjMRiqXYh2owfbcDYN
	XGAJGhahsTJ1zZCw==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Allow pv-calls outside paravirt.h
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-20-jgross@suse.com>
References: <20260105110520.21356-20-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838720139.510.12931938401438004953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     560db12560d4d0fb24ee0c32dc32975e18a88ed4
Gitweb:        https://git.kernel.org/tip/560db12560d4d0fb24ee0c32dc32975e18a=
88ed4
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:18 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 13 Jan 2026 13:50:26 +01:00

x86/paravirt: Allow pv-calls outside paravirt.h

In order to prepare for defining paravirt functions outside of paravirt.h,
don't #undef the paravirt call macros.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260105110520.21356-20-jgross@suse.com
---
 arch/x86/include/asm/paravirt.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 62399f5..ba6b14b 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -588,22 +588,6 @@ static __always_inline unsigned long arch_local_irq_save=
(void)
 }
 #endif
=20
-
-/* Make sure as little as possible of this mess escapes. */
-#undef PARAVIRT_CALL
-#undef __PVOP_CALL
-#undef __PVOP_VCALL
-#undef PVOP_VCALL0
-#undef PVOP_CALL0
-#undef PVOP_VCALL1
-#undef PVOP_CALL1
-#undef PVOP_VCALL2
-#undef PVOP_CALL2
-#undef PVOP_VCALL3
-#undef PVOP_CALL3
-#undef PVOP_VCALL4
-#undef PVOP_CALL4
-
 void native_pv_lock_init(void) __init;
=20
 #else  /* __ASSEMBLER__ */

