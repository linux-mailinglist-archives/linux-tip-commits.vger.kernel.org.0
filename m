Return-Path: <linux-tip-commits+bounces-6788-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62427BD650B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Oct 2025 23:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AF819201AA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Oct 2025 21:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7274F2EA17B;
	Mon, 13 Oct 2025 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t59nrPVL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MxBZT0+D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EC62571A5;
	Mon, 13 Oct 2025 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389234; cv=none; b=nC/rNFUmXRZOCSa/zw4NEOFJosvddvqPOfwEpG+ib1Pr6vl95W2Qg+zkNxL/X+NGlZAHoGTkcuUC68yGBGAK70F1vhpYYwpIk4AyOawAqNCbuSVlsSWueWSPxgcRLun6HA2qbbGZcyY3KSDoEu1h50FsgCx4ZCW4ZT0F4N9Jw/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389234; c=relaxed/simple;
	bh=yLw39X9C42bfFbLTXGU21nPEpgd+DYuZn5uYirK4gTY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=dWDR355NJE8cCnEXMI8/n4nn8Az/SvL4j/gG80whvv5f7dVXj65hz+vBIA2lEsYag4vQeUxea6eJmQ9xd1/620mKKDv8nFEp8T/WmtlfLu0YDCh0jFlGdTDa+WVm1wDqnneNIiab5j9Df9frQpNvD1qErU4npBOR1B6cyW8tShc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t59nrPVL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MxBZT0+D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 13 Oct 2025 21:00:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760389229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=R24TJO4afjKKCWHFfvG5FnAjeh2pGX1RZRyT3wsG1l0=;
	b=t59nrPVLKe5OAy35lq5efVblCtUAGzxcrQ0SYrzUKnaJiCe8X/aWm3urEw55lcac/99CBy
	odclafEEW9R2xfL/m80inH6Uw8+61zPn57rnbxRVwKNasndjJYXi/rlE4Y+tIZAgURV75R
	f1JBvlo5RZIP32GB3zCcKUvQZw3hUoNJ8PF+9XApJgIdaZuuATCRAZ3oNiYtfPdFnqw70t
	rSXnXOdqdNzTApqVaL8663yfPHwIPUx2k5/UoElO3NAbJcuVplI84arRQDXCNYnEavmrwF
	Bl1iwshdidnDbnc1cHc5hUXJgBdHn96Eq28FuInOUoImbMcGWwK8UO+YgXEmeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760389229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=R24TJO4afjKKCWHFfvG5FnAjeh2pGX1RZRyT3wsG1l0=;
	b=MxBZT0+D7GlQf7y1hP5u5OHpt7rwvvvdtssgZe2FDbZ5QRdcxDwM2l+32b+GDbwaCypwfl
	xS9V/XSFAQgWjwBA==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Fix overflow in __cpa_addr()
Cc: syzbot+afec6555eef563c66c97@syzkaller.appspotmail.com,
 Rik van Riel <riel@surriel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176038922777.709179.9638250242820548802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f25785f9b088ed65089dd0d0034da52858417839
Gitweb:        https://git.kernel.org/tip/f25785f9b088ed65089dd0d0034da528584=
17839
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Sun, 05 Oct 2025 23:48:05 -04:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 13 Oct 2025 13:55:48 -07:00

x86/mm: Fix overflow in __cpa_addr()

The change to have cpa_flush() call flush_kernel_pages() introduced
a bug where __cpa_addr() can access an address one larger than the
largest one in the cpa->pages array.

KASAN reports the issue like this:

BUG: KASAN: slab-out-of-bounds in __cpa_addr arch/x86/mm/pat/set_memory.c:309=
 [inline]
BUG: KASAN: slab-out-of-bounds in __cpa_addr+0x1d3/0x220 arch/x86/mm/pat/set_=
memory.c:306
Read of size 8 at addr ffff88801f75e8f8 by task syz.0.17/5978

This bug could cause cpa_flush() to not properly flush memory,
which somehow never showed any symptoms in my tests, possibly
because cpa_flush() is called so rarely, but could potentially
cause issues for other people.

Fix the issue by directly calculating the flush end address
from the start address.

Fixes: 86e6815b316e ("x86/mm: Change cpa_flush() to call flush_kernel_range()=
 directly")
Reported-by: syzbot+afec6555eef563c66c97@syzkaller.appspotmail.com
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
Link: https://lore.kernel.org/all/68e2ff90.050a0220.2c17c1.0038.GAE@google.co=
m/
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d2d54b8..9709818 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -446,7 +446,7 @@ static void cpa_flush(struct cpa_data *cpa, int cache)
 	}
=20
 	start =3D fix_addr(__cpa_addr(cpa, 0));
-	end =3D   fix_addr(__cpa_addr(cpa, cpa->numpages));
+	end =3D   start + cpa->numpages * PAGE_SIZE;
 	if (cpa->force_flush_all)
 		end =3D TLB_FLUSH_ALL;
=20

