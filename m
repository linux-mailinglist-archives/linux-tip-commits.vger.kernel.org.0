Return-Path: <linux-tip-commits+bounces-4589-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C2CA75281
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 23:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33967165E78
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 22:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A35A1E102E;
	Fri, 28 Mar 2025 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g6V1iMuN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ayVerMQW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8D81865E5;
	Fri, 28 Mar 2025 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743201400; cv=none; b=a0/12+t5BcvF5sZrd0DkSRC7vih8V5YCf6fxB38XjGQcrdh8Y/LuYMS7LuVm/umaCR8V3tG9tUSqQ74ivlY4dkgUVu0ujjeGHdNtnx/xRO9NhwcWnHmiI3NWn4VLpISsmc5aGpUxBlRanMN/wd6pe2w63rpeNszOjSwRuRqCUfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743201400; c=relaxed/simple;
	bh=qvT/GEzWlQv6lS0U2m89w/FTN16lT9LTxwh7/03s49k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d4+U46ovnEGI+SC+HxGuv6GJB9HT5I4A12s3RPtVcCKyqUZ/AboosQGGDpND+Yd1mRRGPX+HglmTdgoN4aQpCvgOcYnV8W6JuG1F7L9or91l8z1WnC+rq38poubUTwcza+xIUyULYfmnYE064OYixXY7gy46tHcH22Lr+hSlY7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g6V1iMuN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ayVerMQW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Mar 2025 22:36:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743201396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imv0td6C9/I7VUS8FnHdX0DrFjaHytH6iHSOcrr8ZRI=;
	b=g6V1iMuN9janqVHn9w6rhDh1BFpaTY7CRr5G01jN9ZhPsO8crVMAQbBmqXrPqmVqfi7ikM
	EWrYizHmvaRNywjTJoRJdlnFafHZtGOdLluXkNftgx5IK6yt56zdKEX4FkglkoaBK8zMk4
	m+sCPXAPU2h3jSszLn4TOs6VU52iqwL7ljT7Yzohm2ixwTIkc5Fe8ntINkQ0scTIcdSZRN
	vd9LgUzfs6d64Kmy8tdZWSvCVes0khZdGfeDDYJC3ZhuAGAw2SznnHnHEKAIYdoKuCPO54
	aFN9D8pdhMT5OzLgWGktL6x/6DQNT+czaZLlCfcS4TcWsn/l2J8zYqXf+Mv8NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743201396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imv0td6C9/I7VUS8FnHdX0DrFjaHytH6iHSOcrr8ZRI=;
	b=ayVerMQWtQYUrvjUSD1hT5R+wwd481zcujfUECv2rRGD2LVsiwFJ6O+nl7EmamofHaLJTn
	qfCeom1MJh7iBCBQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/asm] x86/bitops: Simplify variable_ffz() as variable__ffs(~word)
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250327095641.131483-1-ubizjak@gmail.com>
References: <20250327095641.131483-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174320139120.14745.16708448269773254006.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     e29c5d0e5dc35ed8b8920b573925d8aa2f8bafb0
Gitweb:        https://git.kernel.org/tip/e29c5d0e5dc35ed8b8920b573925d8aa2f8bafb0
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 27 Mar 2025 10:56:28 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 28 Mar 2025 23:24:16 +01:00

x86/bitops: Simplify variable_ffz() as variable__ffs(~word)

Find first zero (FFZ) can be implemented by negating the
input and using find first set (FFS).

Before/after code generation comparison on ffz()-using
kernel code shows that code generation has not changed:

  # kernel/signal.o:

   text	   data	    bss	    dec	    hex	filename
  42121	   3472	      8	  45601	   b221	signal.o.before
  42121	   3472	      8	  45601	   b221	signal.o.after

md5:
   ce4c31e1bce96af19b62a5f9659842f1  signal.o.before.asm
   ce4c31e1bce96af19b62a5f9659842f1  signal.o.after.asm

[ mingo: Added code generation check. ]

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250327095641.131483-1-ubizjak@gmail.com
---
 arch/x86/include/asm/bitops.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index bbaf75e..eebbc88 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -267,10 +267,7 @@ static __always_inline unsigned long variable__ffs(unsigned long word)
 
 static __always_inline unsigned long variable_ffz(unsigned long word)
 {
-	asm("tzcnt %1,%0"
-		: "=r" (word)
-		: "r" (~word));
-	return word;
+	return variable__ffs(~word);
 }
 
 /**

