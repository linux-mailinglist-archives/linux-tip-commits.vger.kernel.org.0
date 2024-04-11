Return-Path: <linux-tip-commits+bounces-1035-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5288A1CAC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Apr 2024 19:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A8D1F25D75
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Apr 2024 17:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730731A38F9;
	Thu, 11 Apr 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZfdJ1k4S"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E23E462
	for <linux-tip-commits@vger.kernel.org>; Thu, 11 Apr 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853107; cv=none; b=WTVdpZT/uIBlker2tKIcs4Lx0X6djQWkUoCdypvwzaMAxN7tmWZVypNvTT8IFMMQguJTQerUrzrQW4PoPuToxwCKAOsyS07GG0D8Ip5aSPl96puXBtXfNdyIz16zL4vZAoPNLpmt5TZ6563EpwJkMp7mwnrfTefCYCBVUVc33QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853107; c=relaxed/simple;
	bh=evOUe1w35ZtZ8Av7MI/0lyqOeulmgJE9vxHA7CRHUeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9kopXTai4vWmJRFnqx4xjfX1MSIcvzD8DFZfePaDzsRVFq7QmUbSHidssgn10vm/foLJtzPAObw1gopm0R1D9MrTJ1CXOgmGw13d9jhnLpa+1XUF9wKNbq2/EYHXwqlLX6pLx88QpixweN9OCj5bMazdiv7bKVWveDqo2QsTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZfdJ1k4S; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so6006384a12.3
        for <linux-tip-commits@vger.kernel.org>; Thu, 11 Apr 2024 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712853104; x=1713457904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p0E4Mcvm1Ca/K7JG5a2Gt1iCkk38ClaKkzaJEpcElfU=;
        b=ZfdJ1k4Sqg4AVSPcimXMcjoQVbHBaqv/2ftg737ZM7VU3RngdiLMEXsmZNRwJMOmDU
         7fPletejNBJ9VL99DZy+xDJezPQt6jzHQK+qNhNwyv4AjWb1No2uh9mzkPOTsp5tG9b0
         M2dcPNumPqIZIIvuOFUVfIxctv8f0sAzT6gsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712853104; x=1713457904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0E4Mcvm1Ca/K7JG5a2Gt1iCkk38ClaKkzaJEpcElfU=;
        b=vRZocbuxTsWffJ6xEGE/69kRoJQYSc8iNqdRjhzJRBTWsZXKyFWXoh7VYGnlZ4XRGt
         4Dhy/3T4vUOwLspJxsex8Koh1RVFqAJpF1HeM85RahXnwMLyKlo5TRIU+1tJJBGTy0/m
         O+jiH0v4jHoElaDD3rd8FBAItfNYNJN6OKQzGNPQ1mbKcsrPkGHzICrAbJry2z9YkwGH
         J3FXg9Xokl6/z9DDXLQX07VahGyDGkZpsuhelbCRGm2TyH/M5hAK5eJw/1R87LIItwv9
         kBlB4Wfmtp8u0a6b1Ge5Ehu614/BMn8l9+jYaNAypSKB7Yslgd6KpKi5uZphVPMop9NS
         BO9w==
X-Gm-Message-State: AOJu0YydyblHcMhzcysMnAr+7gedhrDhyCl8A4TNacEiCmMFRfogoqcc
	7y2+pj3coi/22ePLe4zCv+JnaimvIoCzvWTWHIfiL2SdrNewIMhnkiigGzlfN5vUsO76K0SSb2p
	01fAFgw==
X-Google-Smtp-Source: AGHT+IGKRKHL9PEMey39zIvGq3B929cRarcg5A98graelDMTP+sYEIe1hrQwbdF8ryHmexrO3Kz+fQ==
X-Received: by 2002:a50:8712:0:b0:56c:5a49:736 with SMTP id i18-20020a508712000000b0056c5a490736mr215286edb.9.1712853103896;
        Thu, 11 Apr 2024 09:31:43 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id ij5-20020a056402158500b0056e598155fasm806087edb.64.2024.04.11.09.31.42
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 09:31:43 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so11714143a12.2
        for <linux-tip-commits@vger.kernel.org>; Thu, 11 Apr 2024 09:31:42 -0700 (PDT)
X-Received: by 2002:a17:906:f809:b0:a4d:f5e6:2e34 with SMTP id
 kh9-20020a170906f80900b00a4df5e62e34mr160576ejb.19.1712853102671; Thu, 11 Apr
 2024 09:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325140943.815051-1-ubizjak@gmail.com> <171284242025.10875.1534973785149780371.tip-bot2@tip-bot2>
In-Reply-To: <171284242025.10875.1534973785149780371.tip-bot2@tip-bot2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Apr 2024 09:31:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaxi4Sau27C5yo3vty67DHz-f4L6SSOvmx1K2fQU2B_g@mail.gmail.com>
Message-ID: <CAHk-=wgaxi4Sau27C5yo3vty67DHz-f4L6SSOvmx1K2fQU2B_g@mail.gmail.com>
Subject: Re: [tip: locking/core] locking/pvqspinlock: Use try_cmpxchg_acquire()
 in trylock_clear_pending()
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Waiman Long <longman@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 06:33, tip-bot2 for Uros Bizjak
<tip-bot2@linutronix.de> wrote:
>
> Use try_cmpxchg_acquire(*ptr, &old, new) instead of
> cmpxchg_relaxed(*ptr, old, new) == old in trylock_clear_pending().

The above commit message is horribly confusing and wrong.

I was going "that's not right", because it says "use acquire instead
of relaxed" memory ordering, and then goes on to say "No functional
change intended".

But it turns out the *code* was always acquire, and it's only the
commit message that is wrong, presumably due to a bit too much
cut-and-paste.

But please fix the commit message, and use the right memory ordering
in the explanations too.

            Linus

