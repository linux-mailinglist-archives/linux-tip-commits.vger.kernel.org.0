Return-Path: <linux-tip-commits+bounces-5092-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C64A96418
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 11:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311E03A232E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 09:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC751F4C89;
	Tue, 22 Apr 2025 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IH6hWbUY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xuzV9L0w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FD31F4162;
	Tue, 22 Apr 2025 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313757; cv=none; b=iVyvTj4/sDOT1tkDec31/knxSUIMRUQhQ57PPK3NQra1nEujL/KaINoGegDoaEp01NkFY1HAvEu5cBmYAeRJ6HEpsSBM5yxLRINkQOwAEhuFpyyCIbe5DFULq9gljISN3ORV78NXz5VRRoEUlvuDKhtnmCo83a9hiM0zHSYrnoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313757; c=relaxed/simple;
	bh=KkOiWXD0SfVxogsmlLDHSgmAeMF41/BuWSenaeARu0M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WtoG5AQqPdbeQNZpjwlGknKTa9LGxcGPVN4pUqGd+/yfQ9Xqlx5hedf2GAtC+HOat0twyr9kgZ+npoMZdZJc66zDbNhPwVj0zC2DFHmUVDNFvkx5GUR6TzkoWpJp4k/iXVrVKbgOjxNXLTJ0ETjadp2APZn8KDaScJwJNxuCiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IH6hWbUY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xuzV9L0w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Apr 2025 09:22:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745313753;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fk1TA8DErLykkxDUEEEardvX76gec9Hdsa8o/aBzCyQ=;
	b=IH6hWbUY10GGbyjwSXDQlEOMar+1MxFVsZHtPmP/YbPTqkw3XHsRvghjUdwmRVJ/RSvd7+
	jeCT9VEXYZU1BXU/enj8gtiohzjBU0kWPoxPBvJ88sdEia5AhIHVRMv1oEOBBf1pyUWx7m
	7aV3iZkMh5ZihjJAekm/K7ZLJPP/w6CeLFIwJXLl0Txjr9fKqKfN8Nk3xOBNlaYLugzVH/
	8frD2edcGORKAJJdSzljf4mLarUYIyqIT6eqXQ8cIJ7pbSY3rv6bj8wGa0LhdouU7TSo1w
	5gatCR8e3UR9BLEIDjNuLRaJNnMdkgu/mGvH+0dijLlyCgqv6G7DYRYSvNoOWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745313753;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fk1TA8DErLykkxDUEEEardvX76gec9Hdsa8o/aBzCyQ=;
	b=xuzV9L0w8NHvCbYOpJq0QPm78yJhSem6k/hZiJbPx9wiSlrI2oAiJKRW2QPwaaovo1l4sR
	tnfBh1Yl5/mJg3AQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/asm: Retire RIP_REL_REF()
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>, Kevin Loughlin <kevinloughlin@google.com>,
 Len Brown <len.brown@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250418141253.2601348-14-ardb+git@google.com>
References: <20250418141253.2601348-14-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174531374773.31282.2325580312409315487.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     ff4c0560ab020d34baf0aa6434f66333d25ae524
Gitweb:        https://git.kernel.org/tip/ff4c0560ab020d34baf0aa6434f66333d25ae524
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 18 Apr 2025 16:13:00 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Apr 2025 09:12:01 +02:00

x86/asm: Retire RIP_REL_REF()

Now that all users have been moved into startup/ where PIC codegen is
used, RIP_REL_REF() is no longer needed. Remove it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20250418141253.2601348-14-ardb+git@google.com
---
 arch/x86/include/asm/asm.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index a9f0779..eef0771 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -120,11 +120,6 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 
 	return p;
 }
-#ifndef __pic__
-#define RIP_REL_REF(var)	(*(typeof(&(var)))rip_rel_ptr(&(var)))
-#else
-#define RIP_REL_REF(var)	(var)
-#endif
 #endif
 
 /*

