Return-Path: <linux-tip-commits+bounces-2996-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7F79E6BC8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 11:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DD316D75D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 10:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E099E1FF7D1;
	Fri,  6 Dec 2024 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TewfTzPB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VvYqLxyx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444BB1FF7B0;
	Fri,  6 Dec 2024 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480206; cv=none; b=IIOIP9MxwIILIIevALY22hdlv7kjyGtgSLj/T4pEW+op7cFUZBXG5PA7jb6oBwMgKNrvzMniV49Nw0aYHoCRPXrmeteQ5Pid70nJ8jnL1EsGyc2OcxGbw+hpRNGIh5YIDteXqD6rfF8aEvY1ar52KNqMNzF14zUlt9AHR+f2RFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480206; c=relaxed/simple;
	bh=t2vjwvLfB/tl2bBAaZqX/88ujbg81yuKJEVBNGoPwNI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EAv5/PhaHBRwb85sjsSc6zEPW8D79M984R+pS8LHZEcanBFK0LW4KoLqOwQKm+QHU9r63ase4xSbCM4UTOj7wEkWHx7GEeNOjZIxFc1pv2rc2W2iBGXYLJqjvS/krlmKYJNyancVVzABkGS6HqqFR0pTzdIFskbqXXVYzw5hof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TewfTzPB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VvYqLxyx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 10:16:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733480203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KakjtALV88RvEBZpjyNVYn3nyapCQVOiJifGGVwnFY=;
	b=TewfTzPB0s5aIvP+h4NXtwSKsiuTb/BsienKkue730+FENtHJsEgMz27KiH1lHz8NRfVm5
	lIwnhj7SD9t8sf40KnToY2RdbW6p/lYv6IBV8yVLboZkpzdyH2bVJPiHfY/Y28KjocqX2X
	zlB0dgH7T7+tqSlDIiCYrDY8S4Loz4GIM/PIbvOdRAe5Dftvgd2ReqxsfsIaDQWgnve6w9
	ODjeQKs98YZ6RcbVQ+GLx2SRli2QkTOXszXn49JIpHh23hZVokHeOEquZidygd2sGJj7+I
	5ZSGBRubqDkTomZ9xkfzHIJcpZtasm6HmkdTpDg/D6UR3oGUMI+8RRgaAGgvdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733480203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KakjtALV88RvEBZpjyNVYn3nyapCQVOiJifGGVwnFY=;
	b=VvYqLxyxOrD4V2ciW7ztFgx/FkdgulXQhc/nLTuN+XETpgNu5j5gZ+/46cU5t2V2nOXXfF
	olnwVBw4MrhW1rAQ==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/kexec: Mark relocate_kernel page as ROX instead of RWX
Cc: David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241205153343.3275139-14-dwmw2@infradead.org>
References: <20241205153343.3275139-14-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173348020271.412.1058395032860505011.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     5a82223e0743fb36bcb99657772513739d1a9936
Gitweb:        https://git.kernel.org/tip/5a82223e0743fb36bcb99657772513739d1a9936
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 05 Dec 2024 15:05:19 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 10:42:01 +01:00

x86/kexec: Mark relocate_kernel page as ROX instead of RWX

All writes to the page now happen before it gets marked as executable
(or after it's already switched to the identmap page tables where it's
OK to be RWX).

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20241205153343.3275139-14-dwmw2@infradead.org
---
 arch/x86/kernel/machine_kexec_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index c9fd60f..9232ad1 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -323,7 +323,7 @@ int machine_kexec_prepare(struct kimage *image)
 
 	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
-	set_memory_x((unsigned long)control_page, 1);
+	set_memory_rox((unsigned long)control_page, 1);
 
 	return 0;
 }
@@ -333,6 +333,7 @@ void machine_kexec_cleanup(struct kimage *image)
 	void *control_page = page_address(image->control_code_page);
 
 	set_memory_nx((unsigned long)control_page, 1);
+	set_memory_rw((unsigned long)control_page, 1);
 
 	free_transition_pgtable(image);
 }

