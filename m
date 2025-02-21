Return-Path: <linux-tip-commits+bounces-3568-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64875A3F736
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 15:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C63817D177
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 14:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFDE20F092;
	Fri, 21 Feb 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uH1GDmOJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L6mJQBYG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE6A20F07C;
	Fri, 21 Feb 2025 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148077; cv=none; b=KGuDapSF9MMc1Fs0apGYyJwiO1Urxc1S5UzotUx9JHkBxQ6SI69S0ouFoAhJ4WywbYFUAiQeKQpQipjkabpIE/peFLthrWneuj0diyxpf9GT9wQQfer0c88xj6eTleCT/TlfwBjxPdZnVR0mfbS8ZlrQRLTS/QyI3U1gYI2cOe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148077; c=relaxed/simple;
	bh=jdfrMNK94ghqC2jWjx3FWfsRjzJig0XkBNBxQWm8P18=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LVoRhbpYWx3Z+xI/ykqj+LwPXKghZTpIm3jGIIIEBGduxL6s6SUsHPkHQclaDmocAUpNe8pQak97WZSUrpS8YovBrmOLFFjL6yiWLoZSIP8836sCxPc6vRHSIQzneF9Foa8kg7W46D6M5X9vsHufty10aFcCpub53EFjawu7Ab8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uH1GDmOJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L6mJQBYG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 14:27:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740148073;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I3s7xMFV4T0TuKH0rqiq9TlNp2BfzB4Lr5KqGZuRrc0=;
	b=uH1GDmOJCFVEPbdPHAgMYMLX79NNakc112WzwqmkdXQnUzBNrAfqf63ookq9lA1OlMew/Y
	Hjs2/lAKgFDHVWzHcyYGQruz5weDDhSNKPjVcazDrGHKdT7MrjzRkd1PWiNqPIc8GLzODR
	C6Mb73CbYS6HtZP8qrdJ/aaGW3IXZetYojWytdZwUlRuBwqj+kwGZy14TihoawTMh5uZ5p
	cvpCiwvgTyzs+WL8g81yzYCIBCFxhS2g4uLyKXfs5AMnFC/ktwCK1OaZhfLSiqxT3hUlSF
	6Alw4x0n6rTWzFHcdaEovjDa9Lfum19D8p41D3dqnrBUUrO9+pXH0D/1j7GQEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740148073;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I3s7xMFV4T0TuKH0rqiq9TlNp2BfzB4Lr5KqGZuRrc0=;
	b=L6mJQBYGQE+d9LM91bRPFkrkfLg7zVswvnmB4Qa4V1TsrsHnStwXVKsEv3vj7Mt2TJRtOV
	uCrPBvDbXysZHtBw==
From: "tip-bot2 for Artem Bityutskiy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] ACPI/processor_idle: Export acpi_processor_ffh_play_dead()
Cc: kernel test robot <lkp@intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <de5bf4f116779efde315782a15146fdc77a4a044.camel@linux.intel.com>
References: <de5bf4f116779efde315782a15146fdc77a4a044.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174014806835.10177.13242036233718056761.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     64aad4749d7911f8c5e69d93a929a269605dd3cb
Gitweb:        https://git.kernel.org/tip/64aad4749d7911f8c5e69d93a929a269605dd3cb
Author:        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
AuthorDate:    Sun, 16 Feb 2025 14:26:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 15:17:07 +01:00

ACPI/processor_idle: Export acpi_processor_ffh_play_dead()

The kernel test robot reported the following build error:

  >> ERROR: modpost: "acpi_processor_ffh_play_dead" [drivers/acpi/processor.ko] undefined!

Caused by this recently merged commit:

  541ddf31e300 ("ACPI/processor_idle: Add FFH state handling")

The build failure is due to an oversight in the 'CONFIG_ACPI_PROCESSOR=m' case,
the function export is missing. Add it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502151207.FA9UO1iX-lkp@intel.com/
Fixes: 541ddf31e300 ("ACPI/processor_idle: Add FFH state handling")
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/de5bf4f116779efde315782a15146fdc77a4a044.camel@linux.intel.com
---
 arch/x86/kernel/acpi/cstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 5bdb655..86c87c0 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -214,6 +214,7 @@ void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
 	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
 	mwait_play_dead(percpu_entry->states[cx->index].eax);
 }
+EXPORT_SYMBOL_GPL(acpi_processor_ffh_play_dead);
 
 void __cpuidle acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
 {

