Return-Path: <linux-tip-commits+bounces-7668-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB638CBB7F9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 664EE3009771
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DAC2C21CF;
	Sun, 14 Dec 2025 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1V8GNJsh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MDNsM/VW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4380D2C21D8;
	Sun, 14 Dec 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701446; cv=none; b=P1xNKd9Zy4sE6nqmW1wvJ6YyttWOglcwBU7OOMN7AD38TBgjdntSBAlsm7t5+jJ4aVtMBrPoh/csC67USHdqeoyEq9ovRnfJXLyh+MhXPUk2tLDm2CTRn8xgo8pBlCbEjPyaXOF4xALqM5It6WIHygfdEMNZzxBhlANltkIP6Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701446; c=relaxed/simple;
	bh=lfCAwOvkeLhI5/H61iV6CKcNQAx9PTjtdNgnq7W9Y1I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oGkpPTDb8FywEhZE6c4hc9BUM7wpWSqinFMbx/uxikx0T+sx0Gc4QR1V9mOYMJnHX/PIXnzs0AdAPLfg+H0el6Vs6vUNVhBMF7L+cxDDY29KGdiadPCgj2sLtmWTmz5b35NXTcPLaJlkYa6DfheqZ9/UadcOa1qP4QmfC9KuoXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1V8GNJsh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MDNsM/VW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701442;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++g2YL9Vi6SuChyOxy+0c1I9VIxQS7kY30b863iqa/M=;
	b=1V8GNJshtrPuhPl+nO1qxrWZxrFbtumD/AbvhoGlxkcciZc6SPgyCClGkWlr9Wn+qFGDkS
	0aoSy9jpxbmFrskSTGk6svLPuHZ3foojQd95/8gvJc7FIpIsM+oshZNX5j8He9vr1X4rFj
	X6lH+WspJfEaJVcw7VU1rj/xOl4pUanKpvp77qxHAKix0nMoIt2/Tk0faCw1H6+PuOQyaG
	EJNMZ9DB6AD2pJ0cElK4m8cmiyL5B6kEKVEyXfR0MewN9S62gTXAvsNA9lSUzFR1H6VcKS
	7Mgtl63UciAf46Kpoc/ewxkfYlhh1bhYb5y2levkapX6NDdlc+Ujt/kWpYanwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701442;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++g2YL9Vi6SuChyOxy+0c1I9VIxQS7kY30b863iqa/M=;
	b=MDNsM/VWgfzZ5h5MRkQh2BT1rOKNgyaPK85ZTwqd+slQ/vTAiPtPir5UA1/BWmoxxRQhQc
	dP4a6rsrblN5QGAw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Remove e820__range_remove()'s unused
 return parameter
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Shevchenko <andy@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-27-mingo@kernel.org>
References: <20250515120549.2820541-27-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570144146.498.11240101923969945628.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     8b886d8a4db9a75c22cf7d0939f63ca811486efd
Gitweb:        https://git.kernel.org/tip/8b886d8a4db9a75c22cf7d0939f63ca8114=
86efd
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:42 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:42 +01:00

x86/boot/e820: Remove e820__range_remove()'s unused return parameter

None of the usage sites make use of the 'real_removed_size'
return parameter of e820__range_remove(), and it's hard
to contemplate much constructive use: E820 maps can have
holes, and removing a fixed range may result in removal
of any number of bytes from 0 to the requested size.

So remove this pointless calculation. This simplifies
the function a bit:

   text       data        bss        dec        hex    filename
   7645      44072          0      51717       ca05    e820.o.before
   7597      44072          0      51669       c9d5    e820.o.after

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://patch.msgid.link/20250515120549.2820541-27-mingo@kernel.org
---
 arch/x86/include/asm/e820/api.h | 2 +-
 arch/x86/kernel/e820.c          | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index 54427b7..9cf416f 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -16,7 +16,7 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_=
type type);
=20
 extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
 extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type,=
 enum e820_type new_type);
-extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type,=
 bool check_type);
+extern void e820__range_remove(u64 start, u64 size, enum e820_type old_type,=
 bool check_type);
 extern u64  e820__range_update_table(struct e820_table *t, u64 start, u64 si=
ze, enum e820_type old_type, enum e820_type new_type);
=20
 extern int  e820__update_table(struct e820_table *table);
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 806fd92..dfbc6e1 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -548,11 +548,10 @@ __init u64 e820__range_update_table(struct e820_table *=
t, u64 start, u64 size,
 }
=20
 /* Remove a range of memory from the E820 table: */
-__init u64 e820__range_remove(u64 start, u64 size, enum e820_type old_type, =
bool check_type)
+__init void e820__range_remove(u64 start, u64 size, enum e820_type old_type,=
 bool check_type)
 {
 	u32 idx;
 	u64 end;
-	u64 real_removed_size =3D 0;
=20
 	if (size > (ULLONG_MAX - start))
 		size =3D ULLONG_MAX - start;
@@ -575,7 +574,6 @@ __init u64 e820__range_remove(u64 start, u64 size, enum e=
820_type old_type, bool
=20
 		/* Completely covered? */
 		if (entry->addr >=3D start && entry_end <=3D end) {
-			real_removed_size +=3D entry->size;
 			memset(entry, 0, sizeof(*entry));
 			continue;
 		}
@@ -584,7 +582,6 @@ __init u64 e820__range_remove(u64 start, u64 size, enum e=
820_type old_type, bool
 		if (entry->addr < start && entry_end > end) {
 			e820__range_add(end, entry_end - end, entry->type);
 			entry->size =3D start - entry->addr;
-			real_removed_size +=3D size;
 			continue;
 		}
=20
@@ -594,8 +591,6 @@ __init u64 e820__range_remove(u64 start, u64 size, enum e=
820_type old_type, bool
 		if (final_start >=3D final_end)
 			continue;
=20
-		real_removed_size +=3D final_end - final_start;
-
 		/*
 		 * Left range could be head or tail, so need to update
 		 * the size first:
@@ -606,7 +601,6 @@ __init u64 e820__range_remove(u64 start, u64 size, enum e=
820_type old_type, bool
=20
 		entry->addr =3D final_end;
 	}
-	return real_removed_size;
 }
=20
 __init void e820__update_table_print(void)

