Return-Path: <linux-tip-commits+bounces-5087-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD05A95D6B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 07:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469C8173699
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 05:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC663149C6F;
	Tue, 22 Apr 2025 05:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="Mo4T8ut3"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A0A59
	for <linux-tip-commits@vger.kernel.org>; Tue, 22 Apr 2025 05:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745300414; cv=none; b=VVi+gYf74DQ3RVoTgqgLKxMCS9vpAU71DvrbfLo4YwsuO0s9X4BgLqWUxOiIdpQvtY+abY/dXgx3zXLkG9tL2Yj7RDNw0rQaR8WVukNnhU98kjnX3p6o6dVDW4lwHBIOyDzbhPhP9Op6OY7AnkFyB6aON2J9Gf1fcTmkCH3ksTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745300414; c=relaxed/simple;
	bh=0FF0MnoblAlH+QrhdarCtWTxtm4RN1C+Wo2vudhI1/E=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=MEQfG9MtHhKkIAeVwArewV8g6H8LUyd5nbGkxyKXBuMY24QWZJ9aswhEY2g4Dqi4SnVszrAEYtR+ESSeiRkdPiaI8/uWV7MdiHrlP9rYQWQlxWWnBi9U7UzWvfuJ5wmBAMxvP2kz/GhwOqSPkX0/y/bLQk5Hv5tjk9D0nKnUlsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=Mo4T8ut3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22435603572so48647585ad.1
        for <linux-tip-commits@vger.kernel.org>; Mon, 21 Apr 2025 22:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1745300412; x=1745905212; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0uo6jH9MRW4+23SObIwHcGhg568EV0nMnZUc44go4es=;
        b=Mo4T8ut3S2huB7wz1YDIjdn/F9fEbE3sOKu2uPEKbHZX41LAHk0i3utkWf6gwLTfVu
         0zmoAMAmbvDQDHtgEoLfWqOltdx0qZi4DKmD2DLxT/2G9IskL+jct6LbXp5SJQ8fFW9G
         Pah0NnmrtZGEFfyi8sVPkAub/Gjg+gmdIYVcNVBbsLZCPbXV1VMQ3BX04HZ9UgV4t3qx
         pO2CSTpxzxi9a1430/1m+vs8mDhsesbB8x8TIGkJy3C6MpoSYqEmrwY8m36Xgy0klF4m
         9ySRh1np+JsPXeJhmz+clmK1SwgnRAN5yuF64Oir2IuhnK60gkYcI8E1CSIdIYCYaSzy
         B7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745300412; x=1745905212;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0uo6jH9MRW4+23SObIwHcGhg568EV0nMnZUc44go4es=;
        b=FaOMvfFadQkRSTe99b0OeWVE0/DLU77Kx8wcBumfXGLTHXPNPwL/Bj46C7XUEO6pLw
         MPs/6PlnoG9MGcjxvk8JU7flyhpRgoCEUMVg3Sce93hOMdHFF3K7sJvg6JNiUfsKlUx4
         eo5fWq/NApnLvoDZp9Dsb4woYBSgv6dg8oU/vz1TVFCXrj5lrK+rSSQEX+JsUvj2TsKz
         OjQihjLvfVaMW+fAlNyv9UHyw/LpT4kkH+Wq5yWAwVhdbjGkncUTf5FYTG4829JuLiBx
         xgHFeLrqa37JsxMjGpBUJWcW3ouytPJOsHYkOEFrjAiG+47LwGFoeqr4tIGXmh1OkmbA
         TZgw==
X-Forwarded-Encrypted: i=1; AJvYcCW/N1vgZMQouEZi25MX/ikwh5Je4JTOD/eeFyw48lp7B5JxUjSP1uliD42TekU8DDYizkeU7xOmzuvi+dQetBChYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEjhMNGoOV8Qavo/SrUF+Mynn1Cpu8PsuUJkRbw42wI8K3Z4Eh
	y1vdZfDrjz5dLcRFuTJWfduKepaxckkGc7exE3b80Wtl7oXccWbcTEMsC7BGuZouiXh7UO+q3fA
	N
X-Gm-Gg: ASbGncvY/f89L5QvcB1p7iHKmME/ssnrKkCeMPNj44MypqoeytCUuOHpYLxbzWB9I9j
	9TR10GGHbm19woeLqHw63IjMgmrRUoopJXooox6O25anUX/vrXnVm7K7iimhzbkUazIjuRACw0p
	knprb6kHQDjoRx0bhAMLbnYGuKqdZXvGBpwMyiryukrMJi2of16uz9y0udFv7WnOevO15G8pQck
	PfALuIsEC+D9jFOg+m3cerjMXp10Yu767sU0QXZv8bAdttL5niKtarMSYXBd1XLXuKU263EWivM
	HuiLwJ9i+3PfrneeH13tZMU1YYAbAueFkCrfAxrUVpwITN3w5zK/KRftj+2K9+n89xZY2D1q3/s
	FeqlCmQ==
X-Google-Smtp-Source: AGHT+IHFX2iBVnmvm9k6HT7jUmhseocx+YIQDjG1S0GPD7eTxTZWeE62kX2r0hLx7uI6jupXCxyWgA==
X-Received: by 2002:a17:902:ebc3:b0:220:e63c:5aff with SMTP id d9443c01a7336-22c5361b3e7mr198899305ad.47.1745300412145;
        Mon, 21 Apr 2025 22:40:12 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4bb1sm75763575ad.121.2025.04.21.22.40.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2025 22:40:11 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Alexander Egorenkov'" <egorenar@linux.ibm.com>,
	<tip-bot2@linutronix.de>
Cc: <linux-kernel@vger.kernel.org>,
	<linux-tip-commits@vger.kernel.org>,
	<mingo@kernel.org>,
	<peterz@infradead.org>,
	<x86@kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <173642508376.399.1685643315759195867.tip-bot2@tip-bot2> <87zfgfi017.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
In-Reply-To: <87zfgfi017.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
Subject: ll"RE: [tip: sched/urgent] sched/fair: Fix EEVDF entity placement bug causing scheduling lag
Date: Mon, 21 Apr 2025 22:40:10 -0700
Message-ID: <002101dbb349$03e2c7a0$0ba856e0$@telus.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AduzR9bDkCJA9TKXSNW/Jr2cJXlNsw==

On 2025.04.17 02:57 Alexander Egorenkov wrote:

> Hi Peter,
>
> after this change, we are seeing big latencies when trying to execute a
> simple command per SSH on a Fedora 41 s390x remote system which is under
> stress.
>
> I was able to bisect the problem to this commit.
>
> The problem is easy to reproduce with stress-ng executed on the remote
> system which is otherwise unoccupied and concurrent SSH connect attempts
> from a local system to the remote one.
>
> stress-ng (on remote system)
> ----------------------------
>
> $ cpus=$(nproc)
> $ stress-ng --cpu $((cpus * 2)) --matrix 50 --mq 50 --aggressive --brk 2
>            --stack 2 --bigheap 2 --userfaultfd 0 --perf -t 5m

That is a very very stressful test. It crashes within a few seconds on my test computer,
with a " Segmentation fault (core dumped)" message.
If I back it off to this:

$ stress-ng --cpu 24 --matrix 50 --mq 50 --aggressive --brk 2 --stack 2 --bigheap 2 -t 300m

It runs, but still makes a great many entries in /var/log/kern.log as the oom killer runs etc.
I am suggesting it is not a reasonable test workload.

Anyway, I used turbostat the same way I was using it back in January for this work, and did observe
longer than requested intervals.
I took 1427 samples and got 10 where the interval time was more than 1 second more than requested.
The worst was 7.5 seconds longer than requested.

I rechecked the 100% workload used in January (12X "yes > dev/null") and it was fine.
3551 samples and the actual interval was never more than 10 milliseconds longer than requested.

Kernel 6.15-rc2
Turbostat version: 2025.04.06
Turbostat sample interval: 2 seconds.
Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz (12 CPU, 6 cores)

... Doug



