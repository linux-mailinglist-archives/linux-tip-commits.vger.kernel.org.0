Return-Path: <linux-tip-commits+bounces-3956-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D19B4A4EC86
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D285D188EB1F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 18:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6A52475C3;
	Tue,  4 Mar 2025 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SVIEoIXN"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1801EE7AD
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741114657; cv=none; b=dAA04GX0LiN+322qJcvhh9UNijpRkZhdulXj9tINOEwxCEuJSy8gyRkOQjDIARdlFLF321XSVNhqEanakfNjGU7SCoAmwel/Nt7JcyaeOhODUFuzdDLOoRbRz1tuLR8d9GaqsfNwHQ/WU07/DfgJrabAmVKHlYn5Mee82pWikB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741114657; c=relaxed/simple;
	bh=6T9FhHb/JWtxunhRwlvuECiU9TmRmhKYSWtxW63z62w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/FQYCOWjFT+muYao6bwuZlQ/qdzgruhOmtq9aVrXQxX4OsBzYyFYfIevBl2Dg6uJeRrbM1L7hKpzZ0LAc1XNYRz1TJQEcgui46g7EvdPTmm3BB+Y5Io8k7NcGjkLi+sIDxXw8V7JHKhgODi9dSHVv0fo06faPVRQ2CoDSVxV1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SVIEoIXN; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5491eb379so4392265a12.3
        for <linux-tip-commits@vger.kernel.org>; Tue, 04 Mar 2025 10:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741114653; x=1741719453; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wwUaiWfoPUpRoeAAS0kH7mr77gvmAjedPgmddxc8NaY=;
        b=SVIEoIXNcCwjtlwOj1dBF4/p3F4E6SJe3SCefiM8+MsGrZYZQaEtAzKxaIoH2ftrMY
         xZIgmN4gbOAa6RWc/eG0DnL9sZ+vp+zpRzu/3U0B3SwP9y0Gnf3P+W4m9iHU5ke7UPWB
         4Cb/+0nC2TbNNFMm7D9YDmr47iDd9kHoID44M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741114653; x=1741719453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwUaiWfoPUpRoeAAS0kH7mr77gvmAjedPgmddxc8NaY=;
        b=tbKJU7Kv++NuzLTGs9nB25BkatigoFid8z+yS9kWCdivxlNBvtXyrUt2QktGvqVX41
         V1ZFFpn6MdEhIgIolJYmYKBNzMFYidOWCNMin0cSNESNAgJzfXT3OZbBRkP/tivSQRBI
         R64X5MmMCNO1JQ0wH4KAy587OH1PHOp2GjrL50KAfnJdCGRU/1m94cerK9TzOzKaZN9i
         4XdPJFclrLQX6zDFxQENVV9/ztRFwDmpCuLoPexeOg2k4TtonTH1h1IofmfG5SSovoY5
         1pe+LvDil6ikrnw3d10CXsMWW25KWTB63erhCuQ4chkxmBYrwH2UqeFi9buSiXQ9PBL0
         312Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4r24+j0de5q3mFTzFBF+D9mEEhJGYxYNSP2IZQHZ7kQ9SpZvISid0X0Ne8NjIKY+J8IjoOHkwMRVU6xmJQp0MJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yynz3bcEuetYaKhjTPg4ngqd/s8+YHnATg+mQ78FiYVv3PC3/1S
	sRJCDbO6HTjGQzBsWy4x01qKFd2JdpGHRZ6uAFTXKWovf1EPyomBZowLR0Y4OPjLCyML9WMAwBk
	aG09rHQ==
X-Gm-Gg: ASbGncuan/PiuT5O3QqrkMfqDLmy04QMzu88ywER2p5fczR6TRLQ+DKjA7egcPQSX0Y
	AZ5DHI5qG9wRl/RMnUyXb9UQg304fP4EWgAmoKgeF17D1HGR8Ozo11M3dxquQkLEgG3lj/BjXjz
	iHll7YyjJ7TBQixzTkWcWM61uj4nTIzwfw9FsVAEzjyKFpHBlptVGWnlV/A09oOkpTA3gI43AjG
	HHjJpILzQyAa6Gs8XKb9Aw/MJux3pR6zhCgQfLiG5zguuQAzLlW4SK1QJrtPtKyDKVRqfj56sHi
	Ze3hoT8VlMrdie/co5jyIXyGCNXmZqRVBx+czmzRGFaSTlsx7V+tk6DyBIwYhGvIC5+9cMrfuJl
	GcSMrD0c6AVyMXtBwpx8=
X-Google-Smtp-Source: AGHT+IGy3Kda5V69iAUn1hnNSF4jH+wqpjdekWqArx4EQSEt+KTo0KEgT1WDqmY45v7l/gsqPC6SjA==
X-Received: by 2002:a05:6402:234a:b0:5e4:b66f:880e with SMTP id 4fb4d7f45d1cf-5e59f349265mr202400a12.7.1741114653503;
        Tue, 04 Mar 2025 10:57:33 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb5ad8sm8508866a12.34.2025.03.04.10.57.31
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 10:57:32 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abbb12bea54so1077218166b.0
        for <linux-tip-commits@vger.kernel.org>; Tue, 04 Mar 2025 10:57:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJfwBG7If9DKlPF3GXHlnSFHZqAb0O0iBv+amqufCHe5lm1OiK5mKgBESo30GIJ9rQDpWTPyTS0+/NmZPcwLrRYA==@vger.kernel.org
X-Received: by 2002:a17:907:da9:b0:abf:497d:a23d with SMTP id
 a640c23a62f3a-ac20db01cbbmr33101366b.53.1741114650914; Tue, 04 Mar 2025
 10:57:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com> <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
 <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
 <20250304182132.fcn62i4ry5ndli7l@jpoimboe> <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
In-Reply-To: <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 08:57:13 -1000
X-Gmail-Original-Message-ID: <CAHk-=whqPZjtH6VwLT3vL5-b3ONL2F83yEzxMMco+uFXe8CdKg@mail.gmail.com>
X-Gm-Features: AQ5f1Jr_usyxBsXKRNlYO2C44tmlzyfAvMqXf0CKg8l-nZ0GMDd02O2gmQZ-lCU
Message-ID: <CAHk-=whqPZjtH6VwLT3vL5-b3ONL2F83yEzxMMco+uFXe8CdKg@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 08:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Random ugly code, untested, special versions for different config options.
>
> __builtin_frame_address() is much more complex than just the old "use
> a register variable".

On the gcc bugzilla that hpa opened, I also note that Pinski said that
the __builtin_frame_address() is likely to just work by accident.

Exactly like the %rsp case.

I'd be much more inclined to look for whether marking the asm
'volatile' would be a more reliable model. Or adding a memory clobber
or similar.

Those kinds of solutions would also hopefully not need different
sequences for different config options. Because
__builtin_frame_address() really *is* fundamentally fragile, and the
fact that frame pointers change behavior is a pretty big symptom of
that fragility.

             Linus

