Return-Path: <linux-tip-commits+bounces-7579-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA21CA0375
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 17:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23E3E3093CFE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 16:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F343B349AFE;
	Wed,  3 Dec 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HaHcmnv7"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D44349B13
	for <linux-tip-commits@vger.kernel.org>; Wed,  3 Dec 2025 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780599; cv=none; b=mHmnGQsBdUdSAb2tHyBCgUWUi73T6bjmTdsNlkfhcqDbW7exkSgPLxc9K6oPm3xuFlsrmuyOz1kyV1HsaSHnUnY2BgPHIaSzd4H5aiFP1N8AYJeG1YECVzF4DitO5zSu4z5dCNo7qBDWo1mcEWVh1BesWe9Ws1jvW9Gx5TW3rB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780599; c=relaxed/simple;
	bh=S+3Ikkr1+4PNg0ZZRjTtFoT1GJSKEGHZMGID/Sy8ONo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMKdzlApGXTH51AkmmX3J4Ri5+GRfJv8/8YORYBeGnszJ8Qzp+cf7weAiLuPcoTo+g3g+APpR+MBeJIBui50xdsdGAeUqxb3jAJP5PIvO9Ep8tvOkXzAOnc2HWis/WVoQNETydt4e1LU6iIKGnGygN1ckCWLi3XY9XjC1Mnk2IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HaHcmnv7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b73161849e1so1724627566b.2
        for <linux-tip-commits@vger.kernel.org>; Wed, 03 Dec 2025 08:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764780596; x=1765385396; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cC15f0kwwZHK8CmXwrSDlJ06poM8sG8BnohjA6gExkQ=;
        b=HaHcmnv7OKbonfE2On6NWQGAgp5Ln6q4foCKUEvQdfc9VPZq/3DyzBs4zODztJpJh+
         CfMkU9Jk9LdFc28mYwAywk32WdJ1wudxLQX/DK+hoDwCkgqHJlT+4nJ2xncB30jiE5XM
         3Vt/FmJgQ/InTcq6R64tGCiBFhKoAUgJ+qgps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764780596; x=1765385396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cC15f0kwwZHK8CmXwrSDlJ06poM8sG8BnohjA6gExkQ=;
        b=SXMFx4bK2phgZegoWEFwquGpy4eNgje7hyh7FteYeCmmSMfXsfPlWKpstdL6616026
         pBG670nVIpfqwk2Li1vIUASgCJnP3U7/quC/yUBvbR+AVo/grNPkUJySYnEN9lawqOz+
         PtNPPybqPFJloEnAEIVIGsvrUIxUXPEmSa0ox6VCeLDNZpVkOHebmRWoeY5HjfdcKHxR
         GY0JzHYEIu83L7pu1WrYhclpPmoxsPtOa5yriRsTyw+9xooypGRuMHPOEqUiOHmf18P5
         nZUQZcLfD85vLyYC6uVCH71Odio4MNMMSez8OV/wJ4GQ6KhW/QRwO7h8mKq/f1GrgwMH
         5ijA==
X-Gm-Message-State: AOJu0YwfpdqNEcP+I8JTlQPlprdb7nyAL0Js4xNfszk+2o3Qot4wJ9Nz
	fDZdJsWkUrkP0+H0qyRK6O4uvyx8Uf+EI9PvcM12cXc//oG5Xy+NyPbaoJ+xa/foJNag6cTbJpq
	InOC9i40=
X-Gm-Gg: ASbGncstAfFCugvDCqXLjI8YaJqQdKQKufHuJzqvLD2xV19NwhoV2jWV3qde3jQZsgD
	eZPSouee5yf1PX4wdEUuqwh3xRHiJKwsPOtOKJ17HAKZ2Op4TtZaTQBJwFThelosNu8cuJAq/yZ
	2AQYEaEX5BmIrf7jJWQChJ2UesTQjlaFDy8i4qkGD1fBsXdkCqOWx4VhmkMEpNY/vebODgmwwat
	ux4OQ0lJqPfPBXKcTAaG1E0Aw/cVamsExbwWL0s3p/jMaKk1Tv5xgAlmthXW+bREp6dQ4CNSIgt
	BwR44iGqPKr/LGsWI4YQRdh9bvmtyXNxkBKfBNnrxd6zrujEsKf8xsmC0ehHprpkyN9BgN4rcee
	7HtH9qaeOXIuxUGgFkdaqm3VdNpNjir9NBtFNjlQGHAYoGFzjlUSatKpAEiGpHJMNfWeFXQzYqM
	BhuRG26vZfm5d6WksPKH7m3cvJYSbBFDc8xXHKiHKchdFw4TYvH7NOLE8Qn22z
X-Google-Smtp-Source: AGHT+IGVfDkqAdF83ib3ZvdbCA3gEj8CQPcw+uNjXfjtrMr/gnv9VEyJMDU6kDk42Pm/kWtLivOgcQ==
X-Received: by 2002:a17:907:608c:b0:b71:cec2:d54 with SMTP id a640c23a62f3a-b79dc77817amr316703666b.57.1764780596098;
        Wed, 03 Dec 2025 08:49:56 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59ea334sm1819620666b.47.2025.12.03.08.49.55
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 08:49:55 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so5600701a12.3
        for <linux-tip-commits@vger.kernel.org>; Wed, 03 Dec 2025 08:49:55 -0800 (PST)
X-Received: by 2002:a05:6402:34c5:b0:640:947e:70b7 with SMTP id
 4fb4d7f45d1cf-6479c3d5a73mr2981218a12.3.1764780595049; Wed, 03 Dec 2025
 08:49:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c05ff40d3383e85c3b59018ef0b3c7aaf993a60d.1764694625.git.jpoimboe@kernel.org>
 <176478003405.498.13298696533128884255.tip-bot2@tip-bot2>
In-Reply-To: <176478003405.498.13298696533128884255.tip-bot2@tip-bot2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Dec 2025 08:49:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgzL-bCggZOuDU7_f-1jpjus8Oaqtek9T8GdGUexnHYkg@mail.gmail.com>
X-Gm-Features: AWmQ_bnFmc194S2OmC3WaRl9Ot84YE-sJ5CGHqpXV2yK5PpV5qwPS8PMA5W2Q5c
Message-ID: <CAHk-=wgzL-bCggZOuDU7_f-1jpjus8Oaqtek9T8GdGUexnHYkg@mail.gmail.com>
Subject: Re: [tip: objtool/urgent] objtool: Consolidate annotation macros
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Dec 2025 at 08:40, tip-bot2 for Josh Poimboeuf
<tip-bot2@linutronix.de> wrote:
>
> Consolidate __ASM_ANNOTATE into a single macro which is used by both C
> and asm.  This also makes the code generation a bit more palatable by
> putting it all on a single line.

No objections, but I just wanted to say that when stating "this makes
the code generation more palatable", it would be good to actually show
*how* it does it (with just an example).

Because it's hard to read that diff and figure out what the actual
effect is. I can just about see it, but...

              Linus

