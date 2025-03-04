Return-Path: <linux-tip-commits+bounces-3995-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79777A4EE23
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 21:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1AB188FC9E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF82475C3;
	Tue,  4 Mar 2025 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eHTArpvi"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916F31FA243
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119253; cv=none; b=heJx880mUrUHn38gV251BRqfOjmL9QdTZPC1n82aaiOCDOTLhVbmZVDJz/kl7Xg8pjAHacZG4omLgUL9ghslKi/fQJ48/DWBvV5eHMAEX5We23XlQfmJ65Qv+1ScuM98dpg70GTZb2KF5OqQRmaawVbzix0yjivyh5hqGqJhqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119253; c=relaxed/simple;
	bh=otZ2YUUK1H6x0azyQmfRakGXbj0W/8MjqeBHgun7gY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IB3TLbszKtbNmnJnJnBz1yH/oHMNqKhCfjIfy7iLPXf80pg6spRoWcolHkhQN00j/FzuZtn+uzQtcZFimw4Jvm80Gf2yGwbFcONorkyCVLxqzVzzqbxSm7UxBxmA22x9sjW2+f3qA5wBqRrvqRws1jAeSGn2gVMudU4iMX0GoyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eHTArpvi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac0cc83e9adso32625966b.0
        for <linux-tip-commits@vger.kernel.org>; Tue, 04 Mar 2025 12:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741119249; x=1741724049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=49GpfsO5lTCFXPhObY2qREqYNSVKDxhxnjEh7DtFdqw=;
        b=eHTArpvikzS+MtJPdZRA+KawOHulvHkWcFnxvdDEHpbcyrk2828GImpWFHm1gK91zj
         JM9NiGS5zN3OiXuKan9tOvnVBBVqCB//pwXew2x4Lbg6xl7E2DWxzhdsx+E0I2qp4XuO
         hbhAOuljJkyfK2lodPr1p7cP0A2SBLynnfRn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741119249; x=1741724049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49GpfsO5lTCFXPhObY2qREqYNSVKDxhxnjEh7DtFdqw=;
        b=H5/kZi07sb+6ogOJjE73dIrecQunbwYybKwhdnUqHsJdsijIrcgRRqADLtr9lqzMPy
         vJPfJxHH2J+idTa/NnaDHkvaYncCHYqHk12YJ1V2ZZ4sKSpbmeS7JpuHK/VpTFJvL72h
         RzA+s+KMgPwfc2PBmRL2QUmsUDFztmw0QS4h5IuVY01kBI0+HYDHYuOlMpl93/S0ygUF
         QA0to2xoadQZR27kL2Vb+EKFJRY3QF7aJ43Y82GdmPgDqhwts82cswLJFcysp5lYKVP6
         ckMp++Ts09DtFoiLpxbwrvR1Vh0A35OkBuEVM24HI2BS4JTH7kMdaOqwGdgnpyoix9tj
         SIgA==
X-Forwarded-Encrypted: i=1; AJvYcCXZof1ZlDWtoPbHmTIjPMJR+fDM9+LNXx70sHrA/5EeeI0l9Ost9mEcECnkxDR1BeO+wGQlRdHNwkZ7X4NEboae6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxjLv1cov4FTORmH3ESZ9hLe28NHv5H9X84sXPwqTB3jv8+fD
	Tvgrv+53o/EdFyMZ9Z62QFNnsLmGxfJIx39tJtJJgt+o+8cLJaYjDoK2RO4OoI7mkAI3/oFJxeX
	82+aFsw==
X-Gm-Gg: ASbGncsp+nRh8mxyvfZUtNJNjdDNNg22hoijmjrnSi5PZg/YfUzvyvAFhZyg5T7Ibg4
	MrZqOAiYFyH+pVNiQVd4yxR6oWewG+v146hhUvGxM85nj6p71J87B0FjKQgyxW1fRLwhKM0opWY
	h4npUANWRPj/p6siQIN1Aavw1nWTNpX3qiSx2UpYgTY/Opxu1y0subw6e0nAY6AlIPHl2EU3bpr
	1pNJF+SeLmAre7kgRL2PlpVQVnG7hcAidQKV+TDw/+wi8HYFtFd7u0UVpf6pJjidcpo3cqY/32n
	3iZh1f2K9Ov9KO2QMnbghZdxO4wq4ZpgipZboX6mWHLVDkh/xWAd0msEclgUNQO8GBeeiQi/LuT
	u5svl8ORu2nJl6l3puok=
X-Google-Smtp-Source: AGHT+IGd1kfWlswVOeiGKH2bEyYYyCbCKv/QAaMULwtob+IGn4KGNawUrGaJs1zOVt4coJ1xMgc7kg==
X-Received: by 2002:a17:907:7b8a:b0:abf:6d6e:7728 with SMTP id a640c23a62f3a-ac1f12c3584mr373196666b.19.1741119249451;
        Tue, 04 Mar 2025 12:14:09 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1db69942bsm305752266b.76.2025.03.04.12.14.08
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 12:14:08 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac0cc83e9adso32620866b.0
        for <linux-tip-commits@vger.kernel.org>; Tue, 04 Mar 2025 12:14:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXyE2CoSA+rbRMMPebN+iJqGSAnoBV1cCsV1YDdp+Lb+aNs1G22GHUYrUofmA64/mL534Uph7kQSRJFqX9tmXJ00w==@vger.kernel.org
X-Received: by 2002:a17:907:2ce1:b0:ac2:3a1:5a81 with SMTP id
 a640c23a62f3a-ac20f006701mr47671266b.26.1741119247978; Tue, 04 Mar 2025
 12:14:07 -0800 (PST)
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
 <CAHk-=whqPZjtH6VwLT3vL5-b3ONL2F83yEzxMMco+uFXe8CdKg@mail.gmail.com> <20250304195625.qcxvtv63fqqk6fx4@jpoimboe>
In-Reply-To: <20250304195625.qcxvtv63fqqk6fx4@jpoimboe>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 10:13:50 -1000
X-Gmail-Original-Message-ID: <CAHk-=wizdAA_d1yHZQGHoJs2fqywPiT=NJT2wNA0xybV+GVefw@mail.gmail.com>
X-Gm-Features: AQ5f1JoKZIHGqjuCfBykdkEPbT5nD_o-lICTkuKmDUSpS0YyL9JFBzQs2Wrtl3Y
Message-ID: <CAHk-=wizdAA_d1yHZQGHoJs2fqywPiT=NJT2wNA0xybV+GVefw@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 09:56, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> While that may be theoretically true, the reality is that it produces
> better code for Clang.

Does clang even need it? Last we did any changes for clang, it wasn't
because clang needed the marker at all, it was because clang was
unhappy with the stack pointer register define being local.

                Linus

