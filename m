Return-Path: <linux-tip-commits+bounces-7739-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1D9CC7B24
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B20973009764
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 12:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB24F34575D;
	Wed, 17 Dec 2025 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f8oTGMla";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SuB0Rjce"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822A3451AA;
	Wed, 17 Dec 2025 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975089; cv=none; b=ny8etcR31TPwCu9V0eJgSHb1yDtGcO9YU06W1BujG0AcuDaFmM7+IJJKW+PYboCPAY/AEl0y7bZ5CWBR8hlSyzEkTe2CqOkDQw1HlamzGezc3jSrJW8kntY7eTHD1k4x9wyFbXx5RH5D3TwIiQQIaxZ5yaial8eurYwIY5i/ttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975089; c=relaxed/simple;
	bh=XeQ7AvSB5kERAusqawqWCB6TjzvoQxhp9t4mTirKED0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u4oKvPyaB4cZZsbKrtQU/03RVyGXUZsZVj9Zc7dQ+Vw1an0UTZ/2AXA3gvrQUf9Bd9LpUrMxP7+cxlAOH65etG4hMZ9ZVldmjVEiM1ohNMyQlsW8bUSQ+TXMVECOTugy1R0y0H9eiSuTBuS6LKGj4K7D1l5BQ7IwnDKzEPB3u1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f8oTGMla; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SuB0Rjce; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975083;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTeGBY8kt2qiD5ADd+kvRB2u0ZT3khuYCkVAcX+6nQQ=;
	b=f8oTGMla35OM/mP5ghVBCeP/Ky4ZGdv3A/klAig5LQGcGP+dU7rpFXIijcm0fGAmPRJHBi
	fMKTHSuPdnTj5sIWYivFHcU8Q2fdnLH82etSo7xFBNajB+cT69yfgkVgphAC52LCmunTrG
	7LKJKeMpSjOlWTgiKe14lguTQOZogdgDDhWfsZUTymrDA1Vh7gfqpQil34ND4EmF2QxVLt
	S7FD/dSr1jrxyAK3yndanmRVSYW575GMQ5D/h7Yg6xI9roI9tbLE9Dk1s/YkOn50ZtxDdJ
	rWlw9XUdpiXSviet3T3dsl+h4YEyZPney0qc2zqOZLv+OznJRUGJbk+2yXd22Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975083;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTeGBY8kt2qiD5ADd+kvRB2u0ZT3khuYCkVAcX+6nQQ=;
	b=SuB0Rjce7xgPiLK4ajP7v/DNCPLPDKY+yJjJ5Arhj+/UQA5ViYoTPhifIjqaDYZPf0Vwic
	VMKqgblws/UwqGCw==
From: "tip-bot2 for Jens Remus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/unwind_user: Simplify unwind_user_word_size()
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Jens Remus <jremus@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251208160352.1363040-5-jremus@linux.ibm.com>
References: <20251208160352.1363040-5-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597508229.510.343703398295362146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3c48808408af11d6f173c65eee9bd5ca4c53667c
Gitweb:        https://git.kernel.org/tip/3c48808408af11d6f173c65eee9bd5ca4c5=
3667c
Author:        Jens Remus <jremus@linux.ibm.com>
AuthorDate:    Mon, 08 Dec 2025 17:03:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:08 +01:00

x86/unwind_user: Simplify unwind_user_word_size()

Get rid of superfluous ifdef and return explicit word size depending on
32-bit or 64-bit mode.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251208160352.1363040-5-jremus@linux.ibm.com
---
 arch/x86/include/asm/unwind_user.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind=
_user.h
index 7f1229b..6e46904 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -12,11 +12,7 @@ static inline int unwind_user_word_size(struct pt_regs *re=
gs)
 	/* We can't unwind VM86 stacks */
 	if (regs->flags & X86_VM_MASK)
 		return 0;
-#ifdef CONFIG_X86_64
-	if (!user_64bit_mode(regs))
-		return sizeof(int);
-#endif
-	return sizeof(long);
+	return user_64bit_mode(regs) ? 8 : 4;
 }
=20
 #endif /* CONFIG_UNWIND_USER */

