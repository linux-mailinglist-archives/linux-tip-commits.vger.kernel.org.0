Return-Path: <linux-tip-commits+bounces-4072-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9022AA57926
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 09:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B3418903BF
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 08:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ACA18C933;
	Sat,  8 Mar 2025 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvF0XEPz"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002DA322B;
	Sat,  8 Mar 2025 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741421737; cv=none; b=l6RqTJUcKODdyxEG+a6rrh1ATwB7VJdqaA+FiS7i/STWiXVWvemJe/N7lj6Yu3wDpqOBKvOVYa1oqEpe8d9Nehz87dX9JLkAreoegs0pqbRi1OpEW1LlDyl/1/mNlvedceq889bQc6QRXD2kUbnovdPDSSRnhZG965GctqQoqtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741421737; c=relaxed/simple;
	bh=A6HAhJ5iWIlBKQr8uK6TI4u5ak3Q/m+BVi0FDf4kjwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgLyQSGEb1vm5pmRCfXYarLf2maepqe3Y/gsMTNa2DMCk4QM9/kyTCwt05l10P8ikG/FaSx8bbJEMOYnkREle5wq57YQ5dA1ki93bgvNcJSnHB5tb1KCmfobYFQtj6xWMXR4lWQvrrrN+OUxIehMPUbHFPKXvpYCZw+mbs1zcpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvF0XEPz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bdc607c3fso15638655e9.3;
        Sat, 08 Mar 2025 00:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741421734; x=1742026534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhRZ5qeYV7fg9NJD8jAjggcPwI4JyvsnAqqwlxIrmAY=;
        b=dvF0XEPzniPPy4lx/f1W1aqM/wbob+R1Nx+9KJgeUg+Z4Cp42xBWPF7kWOnAchkUtK
         XaTRw1oRmcX7vGZEbKJLLkSpDvMFYSFF4XSsxgcYmB8kV25Mi9kdurvzRq8MMhfqZugt
         roXi5yAHdU74aKpk8lKVHFTMeZM8DEAzuO8XxPGF2bqLzXiFylSwSAHWv3wpcLGnRe0o
         RWGET5JC9hNhyPlYNNDQlWAXJk8rKH8ElPnZBhk3SAoSFSwStVZexR28V6ekzknab3+Y
         7SGm0au928yc4C2XPaK2gOYL/msEqHFoGqpBXhOPFlaxCaVo2UNOhhRWxSxP0b9ZJJO9
         2njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741421734; x=1742026534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhRZ5qeYV7fg9NJD8jAjggcPwI4JyvsnAqqwlxIrmAY=;
        b=wBCV8p5EcAL0bkJqOwDoaltIYQPWKwU2h8n4ZZ1wN9y3l0Flce/46IwlIqIXOWtrpq
         Adu6fCXWsHe4sGMKkCSOyF4bPTtidZwQBndX8eazSZTt3T6beYAt0/HJPSGIZq7ghcQ4
         GBveRhDQoVvEQMTY4UsADwIhMQW9I6hbPNS+0d5peGOaj0hutSVzvLz5Gn/rn4k5nEXj
         o9ZPdfnSH5FpCEX4GeSBPVSA2ASPpF+Tl4iZqzRmIPSBm94XHtfiNHQNntJ04VXkckBQ
         D7FLlDGZhf9gj9nnJFNQf2rktCKjlSCtQQSoVmgViQ0tkJUZeN7ndIge2zl1t1mQtC30
         S6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUebE+V5x5xIs1M+JsF6e+0qu3z7MuiWLXJSv06hBVrlN7PfjGoSFDR4VOUV3jfAeuzPngJgvP1zWggToU=@vger.kernel.org, AJvYcCUu2lsrf48rhnxCT3iORiE/6qXSAvxsWdnXVQ7a2ZJ9flNuuE4bdtBJGPfDqmpIOzvNkPzP0y7e2PGjy+FXI+OuWlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzICWfjo9JywxXsysD8fts54j/EZeWfIzWul2GzPplorReUNycL
	1odmrtdG7dIJv8Wq+qjRLM2j1ir7sGlEqnkW7CPCsFqWFMFC3WLe
X-Gm-Gg: ASbGncuXdk1VQvd8RRn6xg7VQPqNqi1pg3Olsk8GbUwOpMqX2atzZbQHdMjj8N9NJW8
	9OwjWjS1e0opVNsNDr+baUEROVv+CpuGkmplCQRoeI/c6eB0lwOB5eyTxkD+iO75BvSX5xB9RiC
	ADOlj/OcQ3cps2fVbVmT/vmHHsAaRCpHrHkRO7NBVhJhjrKOoWSbYCX3OVkmZfKR3EoNUHOcafg
	RlJjPE2VZkacIs6AINzu29nx1d7XT7p5e+YFfLC+4RtOg0VukaojtN72WrpTH1tf7q8Beq8J3kF
	ulznxEloQ2S7hdTe2KLnMe51HA++IqV8s7jpd+Wal/TDlETwq06ptuOmh4WelY+whBaHugJGncW
	ao3zUSLM=
X-Google-Smtp-Source: AGHT+IEt1U+T3Iau5ZBaKcpZnNSUN6KKmrCzr8zrkTghNRUZI26Ld2yXlXdthxqTCwxzmywCGuQUKw==
X-Received: by 2002:a05:6000:2c6:b0:391:31f2:b99e with SMTP id ffacd0b85a97d-39132d1fc45mr4567564f8f.2.1741421733923;
        Sat, 08 Mar 2025 00:15:33 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfcb8sm8137332f8f.33.2025.03.08.00.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 00:15:33 -0800 (PST)
Date: Sat, 8 Mar 2025 08:15:30 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, tip-bot2 for Josh Poimboeuf
 <tip-bot2@linutronix.de>, linux-tip-commits@vger.kernel.org, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Brian Gerst <brgerst@gmail.com>,
 x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <20250308081530.7c7e4f94@pumpkin>
In-Reply-To: <20250308013814.sa745d25m3ddlu2b@jpoimboe>
References: <174108458405.14745.4864877018394987266.tip-bot2@tip-bot2>
	<90B1074B-E7D4-4CE0-8A82-ADEB7BAED7AD@zytor.com>
	<Z8t7ubUE5P7woAr5@gmail.com>
	<20250307232157.comm4lycebr7zmre@jpoimboe>
	<A669251B-7414-4EE7-B0AD-735E845C0B5B@zytor.com>
	<20250308013814.sa745d25m3ddlu2b@jpoimboe>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 17:38:14 -0800
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

...
> We hopefully won't need those hacks much longer anyway, as I'll have
> another series to propose removing frame pointers for x86-64.
> 
> x86-32 can keep frame pointers, but doesn't need the constraints.  It's
> not supported for livepatch so it doesn't need to be 100% reliable.
> Worst case, an unwind skips a frame, but the call address still shows up
> on stack trace dumps prepended with '?'.

Doesn't 'user copy hardening' also do stack following?
That needs to find all the stack frames (that have locals) and I think
is is more reliable with frame pointers.

	David

