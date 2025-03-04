Return-Path: <linux-tip-commits+bounces-3950-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72925A4EAFA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5921C17CBBE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 18:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7237428F95D;
	Tue,  4 Mar 2025 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hs0x47Gu"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066228F94B
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110702; cv=none; b=azv6BDLzH+IvuBdsvsVGbPM0u/4Jdz5IXeh4L9++YVlkOlqC2e77Eq5iD8BTOXkc9bFmqhskc9j1oXEgZgzv+4NI812ptKR5+tQ8mx72wJq07MnV/PTS8U5yO+k/aMWA6P55lQ/IhA71obiTWH0+YQ6NlHiGoNl66jyjPBulAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110702; c=relaxed/simple;
	bh=t79luk5gNIukJyh6i+Wv7Arv97K595rpQf5m8ULc0FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDqSYTdO5npuzPXVtpeIyVZXJMDRV25WT1GO+k+N8dS6MFtrC8M9YXTNNsfX41VYMJL0jGUEx5grsG1J+MGDBfePukw6g6U41vRKoz7+dza27i3bR/ySSerALLfDkjgesstCXrs5AzS4UkzHohaPgV8V/LWci8qXuaSykL2LuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hs0x47Gu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1107806766b.3
        for <linux-tip-commits@vger.kernel.org>; Tue, 04 Mar 2025 09:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741110698; x=1741715498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ar6zXTooC+qWyNjyHLe77JrEoGxqI/5v2vCc8JEkak=;
        b=hs0x47Gul7wkkgoNw8UV9Eo+PRgIP/cj/hrkEJAWykijoFB8N9VfIFGUXiolky58i+
         gmrWPIK6MmLFbg8olu0uVhb5KxBvmLfEe+ETq+pXI8KSc6SeIzhb9p6VF+oTG+YRlA1a
         MrKgWiaQpU1aXaGLcB0HU/WS+728JO4+FJVcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741110698; x=1741715498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ar6zXTooC+qWyNjyHLe77JrEoGxqI/5v2vCc8JEkak=;
        b=FC06VtDxEC9AXXEuZ8BwDsCyAqEoFxkbESoA542Jod6OpavW1H3rpNJRpcqS/9HWy1
         cHPdRxk4tMrqV/PpcBfxy9ed8EPFBE+vDUb/ktm03EZLADQKnieY+mkGr1d/2qcMGh6J
         AjRcDwx8wCbQ+ueYKJukbSC/BgkVCCuz5FT0Fxm3HKwPqKv3DOztzb4qBk+9t/q3tzst
         yUxCpvIw+HzUuqKvXozMbpF8zxv2dp5+TRP7S+0qVpjG6xSaaER+vg9tBuS6La1tBdyx
         TQTTudHuT2yUWsq3fJOxCNMqvIJQKVwMa9jy9iY2ZtKKDyeyxgR57cQgGHAZPA+hNpdz
         OmvA==
X-Forwarded-Encrypted: i=1; AJvYcCV28BxlAxFFFnA4DHus+Mz9kNLiNQ32+vj3Ru4I/tVdKpwLRW9hZllbHAGEQ1KmncYsleEKPmkKmMmZexEtPq8q4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzORS4rTkjjVFb3sJnKukF8xxFC3UwWTMhfdt5fHeADdwtOWDv
	T/lsYAIUDOhsXJbBhmq6qmhxKLAuJgF6MhQNjeZN6vFXqxwjyAdGNZ6wd5ykMb3ZqhG9KoM2092
	drKY=
X-Gm-Gg: ASbGnctqrOIIwj8tNw2vuoKSxLcz5awAW2TWiY+ZnrtJL9YAiqN3IAMjgm1du0P33hm
	PWLVtpmByFwZaK7eqZfWY9o9mzXHuHO3f89wO4S5Z3w2TNa3IzTCTgVZngMxGZe6lio8SKE5lFY
	gVTX7pMQ7LZvRiVu7jaevzOI9/ItWjYmQsc5NPfp176mxHIsZXSv/BO/yOF+2HJSYciydoGuhw7
	s8hdQ19j88XoDe0vZqlAE/t7vUo3alW027R51ECe+rtzod87ylbR3f0OfEQBHQWB6m3bVqpvHF1
	QkJsoS7qL+opgpzKd/hh4z2Zc9BNqYxUh4YWgfqaoJ3SrgqM6Y7cOJSOqeW7ePuJCbn39zPsVWO
	oOPdveerc/h+2H4p4s8M=
X-Google-Smtp-Source: AGHT+IFln57XtscRZQ1lFxm9unP57+MbpIh1QKC6w+r64+fhigI00i+3TWNgPkiiklgADGDuI8nzvQ==
X-Received: by 2002:a17:906:6a27:b0:abf:40a2:40ce with SMTP id a640c23a62f3a-ac20d925110mr16362466b.31.1741110698366;
        Tue, 04 Mar 2025 09:51:38 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf5dcc376bsm563256366b.183.2025.03.04.09.51.37
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:51:37 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abf4802b242so669269766b.1
        for <linux-tip-commits@vger.kernel.org>; Tue, 04 Mar 2025 09:51:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNsPVe0xbCfwj3PaDGxtYr9W43hs6PoiuEKTm1LW34NNOyecERbO+gEoIq35m9ldykDvHCDovEKP7LLL3xL9VOKA==@vger.kernel.org
X-Received: by 2002:a17:907:3d88:b0:abf:52e1:2615 with SMTP id
 a640c23a62f3a-ac20d844784mr16705166b.7.1741110696701; Tue, 04 Mar 2025
 09:51:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com> <Z8a66_DbMbP-V5mi@gmail.com>
In-Reply-To: <Z8a66_DbMbP-V5mi@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 07:51:19 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
X-Gm-Features: AQ5f1JpAuV2PR2wWFAAmrlYAziJXOcwJeCn_7ccTAn4I_8dDZz982GJ7tyN4tkY
Message-ID: <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 22:33, Ingo Molnar <mingo@kernel.org> wrote:
>
> So Josh forgot to Cc: lkml in this 5-patch series:

Honestly, this all seems to be complete garbage.

Yes, so Josh found a problem with the thing that has worked for years.

Then Josh did it another way AND THAT HAD EVEN MORE PROBLEMS.

So now it's trying to fix up all of *those* problems instead, making
the code uglier and more fragile.

And I'm not at all convinced that the new model works at all. It's a
random "this happens to work around it on the compiler versions I have
tested", rather than some obvious fix.

Put another way: the old code has years of testing and is
significantly simpler. The new code is new and untested and more
complicated and has already caused known new problems, never mind any
unknown ones.

It really doesn't sound like a good trade-off to me.

                   Linus

