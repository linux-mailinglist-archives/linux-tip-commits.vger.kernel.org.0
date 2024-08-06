Return-Path: <linux-tip-commits+bounces-1948-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E30CE948883
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 06:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BCE1B22120
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Aug 2024 04:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADC315C12F;
	Tue,  6 Aug 2024 04:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UISlUp89"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1A82AE68;
	Tue,  6 Aug 2024 04:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722919931; cv=none; b=XrOL9XIi/USTAXtzvVy69oexVG6V2h+x7pnhvkYNaTcMOJwMzqZAe7TPot+JtJp6naYQNmZln3DFzHe3agfOYbsaAJ+E7Yr99sqH7oYpI0Eznb6JQzHNRnCD2EFjLjDV7Gwr1Qa4J67TNgrR+VfNAul41xQTx9jbtuT0KmPyo6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722919931; c=relaxed/simple;
	bh=x0eURfi//wbukmd71y1CHNadJ+VahRjtDEv7uzx63GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D76r6K61iyV18uLPIASE7WugWuUsJI2vHVM4BOOufYrId+WWt6sNJz6xK5aclMOQn0xKZf7qwHI3mhg6o6jx8odvPZ6mvlsHbfV6fBxd5swwzxt4qY1NshZCmdwiEezz922eQ2Wk9UUCWhgvNV72wTg//G1FDxc35bHvcprPPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UISlUp89; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d2b921cdfso198581b3a.0;
        Mon, 05 Aug 2024 21:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722919929; x=1723524729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSygejVA6LXDdhQccdkkL8pIC9uUMcbvdYK7Mqd1ePA=;
        b=UISlUp894F7aoPyZ243xRBNGUuibzAM7srRg6eEkqzThgKNbwMrWjV2rS9J/dX9v4C
         xNBYgbw55kWQFByKqnY1FPRYL3GTzkovqC1X3MGlWmp2psBb61d4BLXMQr3+dggiIE3V
         DDqHLSbfaprcXaEi1sO5H+4qhfsj+YMbVUmYxgG7Co6VB6uaIwK+7iMcxjhaFA22sRqT
         VYzS7w1VsSfnWVyndRhku8vwCLj5C1V/r8nTIH/+7fLkBpM+JvAWYEAwm1Z5WxcO74m2
         Uyrqfy3RkE5Wh1LmQHfJtfGynsK/I6jZWlVh2jMa/AkVe+cZrqewjOGp/8ObeKH5v+ny
         3Lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722919929; x=1723524729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSygejVA6LXDdhQccdkkL8pIC9uUMcbvdYK7Mqd1ePA=;
        b=ZZDhHkXwnHLaRK0nSw1x4/UTBfb49d2Rk7V5Ar5gTjCulGEROrbkGLMsqOVWCzLbMQ
         pq2cTrpbpE0YPQnV7zK+H+8J6ExP/G54kx6NoKhTHiNpExYz4rKcqdkeuSfc30Ovh2j1
         j0iQWVYd9QaTWFP4rlz06VkK6GYuKQ25iMmj9Lj0ehhJFL6dEJ1sNk/hz67XLyn8EHEC
         5ShvtUGc2MMLO3PBbwPQjpsM17orsdEzUHi6Fem6MrtNRQQ8+CxCDVj4aZzU3a6Zc+El
         n6Uxus8WNP4/HA+3Q+EmBpxoVE4P/m9/RM09NLulFU9HbRA4OzHhSc89CkJwT6NUPfAv
         miZg==
X-Gm-Message-State: AOJu0YwZhDrB3aFexkIfcQ5I6Lp/U5XgcZVm+DsWtCbjb7OLrEJXJChT
	dWOcKWXh4xx2tRO6BPRa8nrCFqwWh7XMC2oWFsduZU4qf2F6QMZA1tcnvg==
X-Google-Smtp-Source: AGHT+IGY3HgVlFREDbG4/KUZk3wGdI4AQEbHQIWZa2/Bo8jGvt69WM8vcVYoarGjBYHcerBhQqBw6g==
X-Received: by 2002:a05:6a00:21cc:b0:710:4d08:e094 with SMTP id d2e1a72fcca58-7106cf8ac88mr19539623b3a.2.1722919928848;
        Mon, 05 Aug 2024 21:52:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed1573esm6190122b3a.159.2024.08.05.21.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 21:52:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 5 Aug 2024 21:52:06 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/mm: Fix pti_clone_entry_text() for i386
Message-ID: <e541b49b-9cc2-47bb-b283-2de70ae3a359@roeck-us.net>
References: <172250973153.2215.13116668336106656424.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172250973153.2215.13116668336106656424.tip-bot2@tip-bot2>

Hi Peter,

On Thu, Aug 01, 2024 at 10:55:31AM -0000, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     49947e7aedfea2573bada0c95b85f6c2363bef9f
> Gitweb:        https://git.kernel.org/tip/49947e7aedfea2573bada0c95b85f6c2363bef9f
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Thu, 01 Aug 2024 12:42:25 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 01 Aug 2024 12:48:23 +02:00
> 
> x86/mm: Fix pti_clone_entry_text() for i386
> 
> While x86_64 has PMD aligned text sections, i386 does not have this
> luxery. Notably ALIGN_ENTRY_TEXT_END is empty and _etext has PAGE
> alignment.
> 
> This means that text on i386 can be page granular at the tail end,
> which in turn means that the PTI text clones should consistently
> account for this.
> 
> Make pti_clone_entry_text() consistent with pti_clone_kernel_text().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

With this patch in the tree, some of my qemu tests (those with PAE enabled)
report several WARNING backtraces.

WARNING: CPU: 0 PID: 1 at arch/x86/mm/pti.c:256 pti_clone_pgtable+0x298/0x2dc

WARNING: CPU: 0 PID: 1 at arch/x86/mm/pti.c:394 pti_clone_pgtable+0x29a/0x2dc

The backtraces are repeated multiple times.

Please see

https://kerneltests.org/builders/qemu-x86-master/builds/253/steps/qemubuildcommand/logs/stdio

for complete logs.

Bisect log is attached. Reverting this patch fixes the problem.

Thanks,
Guenter

---
# bad: [de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed] Linux 6.11-rc2
# good: [defaf1a2113a22b00dfa1abc0fd2014820eaf065] Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect start 'v6.11-rc2' 'defaf1a2113a'
# good: [953f776459a83f00ac940dd67c96d226d7041550] Merge tag 'irq-urgent-2024-08-04' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 953f776459a83f00ac940dd67c96d226d7041550
# good: [61ca6c78295e242d4b681003112bfcdc54597489] Merge tag 'timers-urgent-2024-08-04' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 61ca6c78295e242d4b681003112bfcdc54597489
# good: [41e71dbb0e0a0fe214545fe64af031303a08524c] x86/mm: Fix pti_clone_pgtable() alignment assumption
git bisect good 41e71dbb0e0a0fe214545fe64af031303a08524c
# bad: [dd35a0933269c636635b6af89dc6fa1782791e56] x86/uaccess: Zero the 8-byte get_range case on failure on 32-bit
git bisect bad dd35a0933269c636635b6af89dc6fa1782791e56
# bad: [3db03fb4995ef85fc41e86262ead7b4852f4bcf0] x86/mm: Fix pti_clone_entry_text() for i386
git bisect bad 3db03fb4995ef85fc41e86262ead7b4852f4bcf0
# first bad commit: [3db03fb4995ef85fc41e86262ead7b4852f4bcf0] x86/mm: Fix pti_clone_entry_text() for i386

