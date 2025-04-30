Return-Path: <linux-tip-commits+bounces-5151-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C91BAA5010
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 17:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65D27A7731
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 15:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AEF219E93;
	Wed, 30 Apr 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rwWn4VTq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TdQdA3GC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713D720CCE4;
	Wed, 30 Apr 2025 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026515; cv=none; b=WxcrEl6Gxu6TXd4dJtQLXEzdxrEhDpDE6a/SfUwEKEQnZHEGcLsfTcZ4gW8NCZ0GrpartRh/Ppk6dtfzDVm9wwO+a/pnLJCiSJRJMsRBX+pTiUTl1AnlBwZbzY4B0E9Yuobsk9bdDofGEz6DzgPmnlGMyyX40PtoHjkz84A2XvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026515; c=relaxed/simple;
	bh=lKmd53gZu4sZuMWovJkl8sg3t6gwAHm6zuqk3EmqbIs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pBJE0ao/7BToptsBClO3WEHpYQxFyHMuUXt0QwTyj2nOgxJhpBGhbCnfM/gUsdEMBx8tIxzcj0YWfvy2fQK5I7RUN0LuB1r6HxFJCWYWlSIWTy3OKHzEYDJWTjH4GdUtykBqP9VOWJ7FUfv1Gcrm3z87CQhJO5KWTxn1JsyNRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rwWn4VTq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TdQdA3GC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Apr 2025 15:21:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746026511;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTrXUJ8uWmtUfrDQ/bOE/lzxWV9miQFyESrvKu9cRSs=;
	b=rwWn4VTqDCWXttpIL37+0j/6Aaa59dhh0ZNXYKuRwcLf+S2DC7IJPNPr02h5U5KiieSBIc
	VuQP+yREbMu8V0DDzhj3QceqKjmWjgfgdHRkfsxADT/RKGyt095KVmauOj0zg+cigyYcno
	PFMYgtnGWtRg+c4JmD6b9xbJcXGWdbBj6I96QGDiswAx4yn2auK5MoFhQFjKwaakAou8hJ
	/VyWMZfnGK2qIJiNpgkdo0+K7mHoclCPwH1U9lVkQFj7INFzq45tlKuGGQoNERs2Fc4xEi
	4CwIo8v9rv2nFXztDXSBtOyVr/s9MH93RA0//6SMi/fZfgT0oEgjw4Z0PTwegA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746026511;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTrXUJ8uWmtUfrDQ/bOE/lzxWV9miQFyESrvKu9cRSs=;
	b=TdQdA3GCKKEKa0oLglmMFb9YQTAjgsLopgKXw/bKdcky4hP3rJS7V/DUhEf9EBQpzELRcM
	CwWnCxQmZArwggAg==
From: "tip-bot2 for Annie Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Do not return error when
 microcode update is not necessary
Cc: Annie Li <jiayanli@google.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250430053424.77438-1-jiayanli@google.com>
References: <20250430053424.77438-1-jiayanli@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174602650759.22196.2016156297642927611.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     b43dc4ab097859c24e2a6993119c927cffc856aa
Gitweb:        https://git.kernel.org/tip/b43dc4ab097859c24e2a6993119c927cffc856aa
Author:        Annie Li <jiayanli@google.com>
AuthorDate:    Wed, 30 Apr 2025 05:34:24 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 30 Apr 2025 17:10:46 +02:00

x86/microcode/AMD: Do not return error when microcode update is not necessary

After

  6f059e634dcd("x86/microcode: Clarify the late load logic"),

if the load is up-to-date, the AMD side returns UCODE_OK which leads to
load_late_locked() returning -EBADFD.

Handle UCODE_OK in the switch case to avoid this error.

  [ bp: Massage commit message. ]

Fixes: 6f059e634dcd ("x86/microcode: Clarify the late load logic")
Signed-off-by: Annie Li <jiayanli@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250430053424.77438-1-jiayanli@google.com
---
 arch/x86/kernel/cpu/microcode/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b3658d1..2309321 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -686,6 +686,8 @@ static int load_late_locked(void)
 		return load_late_stop_cpus(true);
 	case UCODE_NFOUND:
 		return -ENOENT;
+	case UCODE_OK:
+		return 0;
 	default:
 		return -EBADFD;
 	}

