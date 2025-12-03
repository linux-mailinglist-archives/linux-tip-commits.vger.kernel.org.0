Return-Path: <linux-tip-commits+bounces-7601-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CED5ACA1570
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 20:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 356A832AC10D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28D132F74F;
	Wed,  3 Dec 2025 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HV8+XaXR"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D60E32ED21
	for <linux-tip-commits@vger.kernel.org>; Wed,  3 Dec 2025 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764787313; cv=none; b=oaBPjs3OjiSZmv/vYDjlRFM0aGrsHqcZlKuW0OMxx8UcFcBZ2vGCbvlz96ZjSuGWdj5pWtxssL7s62E2fJ7hhUGjO1ON9uNtsSSmGpQVZ7MmfUvZNyMD1XlueVKfGxjQ4jgVwghqInusBi0IE7cNKxD7PAnCwzvh59OfktvfusY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764787313; c=relaxed/simple;
	bh=CV55eUlW8saHjocfRfirupuBaVyhXflNfgIHHlxl1ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jb0KTXT1nq3RwG5FVDUkqykDf/x+ZfLjK5ghGoBrzG6XFJ/ni0r3LgC4oLjKOREy+uggXjHiou+zPmmy5lPzY2T1aD5Xxca/kj6tRnz7flRIqTjB3lvLaeGeB8mV67rgJNwI6QEZCKbbKafp7mVPxzBAxVpRGmCvzfXFwcQSSL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HV8+XaXR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so57229a12.1
        for <linux-tip-commits@vger.kernel.org>; Wed, 03 Dec 2025 10:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764787310; x=1765392110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OPGcFtQ55a5qDTe8DUVpXHrYxedgvMNqH5t42qUtk7o=;
        b=HV8+XaXRlaWK5kUA4T/J2IAM4f/uJ7AS5t4UvWGxbhxWxo1NvEVZqQdPWEPpi84B1V
         5caEVtIfH85xTvnm5PmsGmuMzLuBoYCQPIqfsHNEBPwfWD+5k72eLMtL2bZ3qZryO/uY
         mCYX42FOLlwij5MMq7/0tuJ/p9AFz72WLKyN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764787310; x=1765392110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPGcFtQ55a5qDTe8DUVpXHrYxedgvMNqH5t42qUtk7o=;
        b=rpjyDXY9et/80szBx2ipp+7u2STGbEGcgU2ouU6Hcimc9V9qJyVVakVSlT6plwmJgc
         /G7ugcZmWFlkkh/bC/AMVGpp0P1KfSfyukSaA8G4d8MagtCRfAAJC36aPdPS9Ufg9Wls
         zTzJWRmvkWtMYKLJritigLmKQLF75vY6eTodTLLjLEt3QB5GJokq/JvAMSeQ8uBhzi8d
         mS0f3j3TFDl6y5rwOGTKnSmk1vQCQTdAlRoQnTwL5IwMmEsCv0GLicgdOcpwAwdhMXrl
         clfVu5lBuuRyhPSfDxBjF3YnwoZsZ43J5pSJQGpVgJoi4+A24yOSl+dFdpuupSIUtaVh
         WPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL4oNeGn+ewa5lnc5WN5gAACONbUd4BCacNyXc+UlbzgEDfNiWtqLJ2hCLsuCa2wiILY8UAIit4SpUFBq2GpBNWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3o1YxEtZxQTBfbe+F9OMemao3UrPi16vVaBQ81UsRCBuvEwsE
	HzLBJD6bWPP5KHovyQ3LiKco3uRpi7L6ftiiQtzoGFFe5xISQGBANL6J1ZDNPkWy/9vqRfRS71B
	tZmW8pPU=
X-Gm-Gg: ASbGncvXR981Wi5oD49+OK4oJ8IQTvlq0V3dV7NWf2fQtwvieG8DL1jk+ZLeP3qlmCK
	nMn3Q4o5TtrnBhTSC6myyd8pGCOHiWS10XIQHgkS42YtNynG5mo/GEPF8GvQF5tjHT3vs5opvFT
	rBmqTKzFMkJarfmEZBq4PwbSailtj4HOOf/H2ceYAVF15VStk2SIHXZK5xvIfp2lZyp6svDxmur
	oxipnjzpixgib17WvM/rrg+u/C/ombqwAQsfNkUMYT05+8N9zXDxRRQrZeuCFYcMf9GQfPzrux6
	FYmbvq6TRgCSwAdNjiJkt6eedhFZedcCgVKUmduQG6rwk2xAlLPqYckXBUH/NESYGW9M4vGvGqz
	RnnLkG3rWfN6D7giLc7kVjkmyjCMgZJBDobAiQKrobdzjCgVI65LO96S39j1lzpxAPeZbsFWjkU
	YagOEyQuayvO2BwTuXx5ubyamBCTHvSaagK4RDbcnl6aQgNr+hMaK539ZaTfA7
X-Google-Smtp-Source: AGHT+IHersdBCEuK1Q7SqrCuq+NxjRV+9TZgTtSr2dociWJzITRHyrs+xKTtX/96n030R/pBwMstTw==
X-Received: by 2002:a05:6402:3050:20b0:645:d3fe:8c57 with SMTP id 4fb4d7f45d1cf-6479c4e73bcmr2334079a12.18.1764787309617;
        Wed, 03 Dec 2025 10:41:49 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751035c24sm19042013a12.22.2025.12.03.10.41.48
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 10:41:49 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b79d1247240so12716866b.0
        for <linux-tip-commits@vger.kernel.org>; Wed, 03 Dec 2025 10:41:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2KIjhGXVvEj6CRbe0R6jgh9l2RLFISbcIDRqAt1wtJh+K6wsAqr5nXoCVQ7pnamGgGgLBW9WGrUDyRNDYSfPbGQ==@vger.kernel.org
X-Received: by 2002:a17:907:7ea2:b0:b79:9b1b:aad9 with SMTP id
 a640c23a62f3a-b79dbe8cc96mr352665066b.6.1764787308471; Wed, 03 Dec 2025
 10:41:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c05ff40d3383e85c3b59018ef0b3c7aaf993a60d.1764694625.git.jpoimboe@kernel.org>
 <176478003405.498.13298696533128884255.tip-bot2@tip-bot2> <CAHk-=wgzL-bCggZOuDU7_f-1jpjus8Oaqtek9T8GdGUexnHYkg@mail.gmail.com>
 <aTBr3ImmrJQe4G49@gmail.com> <CAHk-=wjc4BeSu7dHB=5AuQNWQ=sOGAuH4j0=uRwsGyiSo+m+bw@mail.gmail.com>
 <72juhabxma7rw5eq2gglct4lmeoqfvrlv5jf36sdcfimz5rxxd@gnfuxdgv6stj>
In-Reply-To: <72juhabxma7rw5eq2gglct4lmeoqfvrlv5jf36sdcfimz5rxxd@gnfuxdgv6stj>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Dec 2025 10:41:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wibTBOrb+T67uBCuXXQxDNtsS_KdMQCvgorUC1CPdHwzA@mail.gmail.com>
X-Gm-Features: AWmQ_bnQ5luRQSgMhzzSL3h6JbjF5hzIRmQeVd0RE4LgBI4Re52pFbPkcH2YDmI
Message-ID: <CAHk-=wibTBOrb+T67uBCuXXQxDNtsS_KdMQCvgorUC1CPdHwzA@mail.gmail.com>
Subject: Re: [tip: objtool/urgent] objtool: Consolidate annotation macros
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Dec 2025 at 09:46, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> So that mergeable thing is the only way to convince the toolchains to
> allow setting the section entsize

Ugh. What a horrid reason. That *should* be trivially done by just
having a linker script setting, but if one doesn't exist...

What are the actual entry sizes, though? Because maybe we could just
use alignment instead - which is trivially settable in the linker
script.

           Linus

