Return-Path: <linux-tip-commits+bounces-3803-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8B9A4CAFB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B4B1895562
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 18:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE94322D4C4;
	Mon,  3 Mar 2025 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FCFfmUKh"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A727B217F33
	for <linux-tip-commits@vger.kernel.org>; Mon,  3 Mar 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026512; cv=none; b=Yb6CRAmoeP5i0nTdLZkKQjIMDKxIo5Eg7cb++ha/cHJLdcE9+itC296lwi3J4IEv2u8UDqhd+AeS+x+k92nh3c0/jBLaPjh07wRzrhop33jUVJHH853pLIWbhqKDBQTlA4dRJe6WV5+aUm5KwPekN/6vUt4qlc6wJW2Uww174+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026512; c=relaxed/simple;
	bh=LJlJ9+pfOZXD2l9ILKB0AraWpZl4WF3Irkph39J2hTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9BEW8wBND2Zx0uyBfb8hlIdZg6H3WOjrSfqAuPRUx7r3EYCaNbA0Kpix84G8og/Iwzg1Z3pt/pRhIcMibeOHQdbxfaa6weTSz/vYg7UG530VLmqg5Q1ShqeyQXo7DOdq1R65UWx0XsIR79flBIUvTAjOy8qK4ggBvpWhr7ECJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FCFfmUKh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abf4cebb04dso444803166b.0
        for <linux-tip-commits@vger.kernel.org>; Mon, 03 Mar 2025 10:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741026509; x=1741631309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PiuymdUWUCngSn51k54uj1Me9yyCCIJ/YBBpvsVy4sw=;
        b=FCFfmUKh2NVH2XNKzWAZPsxP+FV/5dfUm118pWNPpcNA9363Wta3BkEYcI/U3gZDtA
         1wLDXiepfxb16+5f0mcJJTzBjn/hrNt5rbyksLNQUiRLtTF0kpdUe3UV8Fk9yhi0p4oz
         58OjtGbGXxXwFYCmpn88s8n8nXV94ZlECHs54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741026509; x=1741631309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiuymdUWUCngSn51k54uj1Me9yyCCIJ/YBBpvsVy4sw=;
        b=YA72bB62NR+tR1N1tgnruFGlGws/+PO6DtvCaVX7xl9RJOoo/RnIuo5iJbxgWMniQX
         Vp0WEwcFkZQa16vgNLiPudw9A4OxvbgaURoeayw3M6zADmphtwphj1lQRtMOTcmZkWAn
         OZEAXNpD8fo2yx+Nx9PEQNGHrS1qvBXceGGHaVOleytrAW34w19Urxe5e3oGD15pHW25
         dnWxDGGptvAZq9yf6O165bWgksGai6jCWpU03BeYYPsX9xbHXU7Vv4gpoNxqrBUV9mAm
         VubCvhhb30QUo8FbwlyZwtiOy3F2EP/kdFuCVB1T8w5t/6aSx8p0raEueu2zqN8Kl25w
         KkkA==
X-Gm-Message-State: AOJu0YxGsFbP44o5Y0SoY7GSsLf3EiV1nhfjU0PigHHpCjKM0YNqQ//a
	+cPMfAaJxuCVADp/A/c5PUCstitva9wbCNgcw1nMJzkb1sFDJ0JFwF3+Th3qqhADLQkfjzgINZE
	S5KE=
X-Gm-Gg: ASbGncuUy5UgqWF5SQe8fvla0nCcNli9OwYkEDen/4kitOiT1rv++L1AuyMc4JN5qML
	GubxDkt5XuHoiXPehmUboMPKpxXyFH/61ALKmqXFQtB8la6m5zxSBdRuTpg/HXU3hjeA4JUU6UF
	5g44iu3PMFsB0LKdag/OZHxOCzf+Q9JBy+lTTG3WWwalztXaQ4SHr2/8Mgot190ft9KB2PqRql1
	8ue2Qn7tb/ZXKFef4D+3l6VICpIVkvrAPJER2SrDIEKfv33iSde8g+QCwzOonz1JA4dFzqE1hJC
	XmB/zygyXG6H74IHbHgwzLvSUQseCEgt97NBkmG+gjFMbRLCA8kdZZ8crqL1nMAVcyPCg8uVnwf
	mZcVNs/rGTpcotQuqZwk=
X-Google-Smtp-Source: AGHT+IFWOP87NmqXINGKv4kmT++MYzlbOeg+LNaqTsKCa/cl9vxvqKoM8gxAdseGGhRR2sI4vbbVGA==
X-Received: by 2002:a17:906:c150:b0:abf:4a62:6e5b with SMTP id a640c23a62f3a-ac1f0e60023mr29471066b.5.1741026508684;
        Mon, 03 Mar 2025 10:28:28 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf78b8253dsm232221566b.140.2025.03.03.10.28.27
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 10:28:27 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac0cc83e9adso207514666b.0
        for <linux-tip-commits@vger.kernel.org>; Mon, 03 Mar 2025 10:28:27 -0800 (PST)
X-Received: by 2002:a17:907:980e:b0:abf:6e87:5148 with SMTP id
 a640c23a62f3a-ac1f13720f7mr23433866b.23.1741026506915; Mon, 03 Mar 2025
 10:28:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
In-Reply-To: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Mar 2025 08:28:10 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
X-Gm-Features: AQ5f1Jp9645mgpnQPPP7_mu4D7GdZbGoQmNM73EpDQqK94X1yTpIjhLLMBkkATc
Message-ID: <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 01:02, tip-bot2 for Josh Poimboeuf
<tip-bot2@linutronix.de> wrote:
>
> x86/asm: Make ASM_CALL_CONSTRAINT conditional on frame pointers
>
> With frame pointers enabled, ASM_CALL_CONSTRAINT is used in an inline
> asm statement with a call instruction to force the compiler to set up
> the frame pointer before doing the call.
>
> Without frame pointers, no such constraint is needed.  Make it
> conditional on frame pointers.

Can we please explain *why* this is done?

It may not be required, but it makes the source code uglier and adds a
conditional. What's the advantage of adding this extra logic?

I'm sure there is some reason for this change, but that reason should
be explained.

Because "we don't need it" cuts both ways. Maybe we don't need the
ASM_CALL_CONSTRAINT, but it also didn't use to hurt us.

The problems seems entirely caused by the change to use a strictly
inferior version of ASM_CALL_CONSTRAINT.

Is there really no better option? Because the new ASM_CALL_CONSTRAINT
seems actively horrendous.

                Linus

